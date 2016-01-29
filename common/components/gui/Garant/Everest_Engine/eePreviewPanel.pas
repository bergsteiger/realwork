unit eePreviewPanel;
{* Компонент для Preview. }

{ $Id: eePreviewPanel.pas,v 1.2 2014/07/01 12:19:54 lulin Exp $ }

// $Log: eePreviewPanel.pas,v $
// Revision 1.2  2014/07/01 12:19:54  lulin
// - пытаемся собрать несобирающееся.
//
// Revision 1.1  2010/12/08 20:06:29  lulin
// {RequestLink:228688602}.
// - рисуем правильные связи между компонентами.
//
// Revision 1.67  2010/10/26 13:02:53  lulin
// {RequestLink:237503905}.
//
// Revision 1.66  2010/03/02 13:34:38  lulin
// {RequestLink:193823544}.
//
// Revision 1.65  2010/03/01 16:45:09  lulin
// {RequestLink:193823544}.
//
// Revision 1.64  2008/04/02 14:22:03  lulin
// - cleanup.
//
// Revision 1.63  2007/12/04 12:47:34  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.56.14.15  2007/02/12 18:44:58  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.56.14.14  2007/02/12 16:40:22  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.56.14.13  2007/01/24 10:21:40  oman
// - new: Локализация библиотек - ev (cq24078)
//
// Revision 1.56.14.12  2007/01/20 15:31:03  lulin
// - разделяем параметры операции для выполнения и для тестирования.
//
// Revision 1.56.14.11  2007/01/17 17:53:34  lulin
// - сужаем список параметров для тестирования операции.
//
// Revision 1.56.14.10  2007/01/17 14:02:39  lulin
// - вычищены последние нефиксированные параметры в тестах операций.
//
// Revision 1.56.14.9  2006/12/22 12:19:18  oman
// - new: Для статусбара кроме списка строк передаем еще признак о
//  необходимости вывода переливающегося  прогресс-индикатора
//  (cq23938)
//
// Revision 1.56.14.8  2006/12/13 15:57:17  oman
// - fix: На время построения превью запрещаем переключение между
//  выделением/справкой (cq23846)
//
// Revision 1.56.14.7  2006/12/11 09:53:04  oman
// - fix: в ComplexDocumentPreview можно было установить в качестве
//   current совершенно любое _preview.
//
// Revision 1.56.14.6  2006/06/20 13:13:50  oman
// - fix: Сохраняем флаг серый/цветной при переключении между
//  текстом- справкой-выделением (cq21390)
//
// Revision 1.56.14.5  2006/02/03 14:51:11  oman
// - fix: Операции с печатью недоступны если превью еще не готово.
//
// Revision 1.56.14.4  2005/12/01 06:10:37  lulin
// - интерфейс _preview перенесен в более общую библиотеку.
//
// Revision 1.56.14.3  2005/10/11 10:34:21  lulin
// - bug fix: не собиралась библиотека.
// - панель _Preview переехала в библиотеку VT.
//
// Revision 1.56.14.2  2005/10/10 08:09:47  lulin
// - общие файлы вынуты из ветки.
//
// Revision 1.56.14.1  2005/09/22 07:55:20  lulin
// - при определении возможности печати учитываем триальный режим или нет.
//
// Revision 1.56  2005/01/26 14:31:40  lulin
// - bug fix: не все операции запрещались.
//
// Revision 1.55  2005/01/26 12:36:43  lulin
// - new behavior: запрещаем операции печати в отсутствии принтера.
//
// Revision 1.54  2005/01/12 12:47:35  lulin
// - перевел модуль afwFacade в глобальных процедур на метакласс.
//
// Revision 1.53  2004/12/30 14:04:28  lulin
// - теперь TeePreviewPanel сама поддерживает операцию PrintDialog.
//
// Revision 1.52  2004/12/24 13:49:39  lulin
// - bug fix: очередной раз отъехало обновление Caption формы _Preview.
//
// Revision 1.51  2004/12/23 15:34:04  lulin
// - большинство операций перенесено с формы _Preview на панель _Preview.
//
// Revision 1.50  2004/12/23 10:19:49  lulin
// - PreviewPanel теперь сама управляет строкой статуса.
//
// Revision 1.49  2004/12/21 17:54:49  lulin
// - класс TeeCustomPreviewPanel теперь поддерживает интерфейс IvcmState.
//
// Revision 1.48  2004/12/21 17:33:33  lulin
// - new class: TnscPreviewPanel.
//
// Revision 1.47  2004/10/25 16:18:05  lulin
// - вся логика из TeePreviewPanel переехала в TevCustomPreviewPanel.
//
// Revision 1.46  2004/10/25 15:46:17  lulin
// - cleanup.
//
// Revision 1.45  2004/10/25 15:29:19  lulin
// - cleanup.
//

{$Include eeDefine.inc }

interface

uses
  Types,
  Classes,

  l3Interfaces,
  
  afwInterfaces,

  vtPreviewPanel,

  vcmExternalInterfaces
  ;
  
type
  TeeCustomPreviewPanel = class(TvtCustomPreviewPanel,
                                {$IfNDef NoVCM}
                                IvcmOperationsProvider,
                                IvcmState,
                                {$EndIf  NoVCM}
                                IafwStatusElement)
   {* Компонент для Preview. }
    protected
    // operations handlers
      function PreviewGetTarget(const aPt     : TPoint;
                                out theTarget : IUnknown): Boolean;
        {-}
      {$IfNDef NoVCM}  
      procedure opZoomWidth(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure testZoomWidth(const aParams: IvcmTestParamsPrim);
        {-}
      procedure opZoomPage(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure testZoomPage(const aParams: IvcmTestParamsPrim);
        {-}
      procedure opGray(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure testGray(const aParams: IvcmTestParamsPrim);
        {-}
      procedure opInfo(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure testInfo(const aParams: IvcmTestParamsPrim);
        {-}
      procedure opFull(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure testFull(const aParams: IvcmTestParamsPrim);
        {-}
      procedure opZoomIn(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opZoomOut(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opPrint(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opPrintDialog(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure testReady(const aParams: IvcmTestParamsPrim);
        {-}
      procedure testCanPrint(const aParams: IvcmTestParamsPrim);
        {-}
      {$EndIf NoVCM}  
    protected
    // interface methods
      // IvcmOperationsProvider
      {$IfNDef NoVCM}
      procedure ProvideOps(const aPublisher: IvcmOperationsPublisher);
        virtual;
      {$EndIf  NoVCM}  
        {* - предоставить список доступных операций. }
      // IafwStatusElement
      procedure IafwStatusElement_GetStatusInfo(out theString: Il3CString; out theNeedProgress: Boolean);
      procedure IafwStatusElement.GetStatusInfo = IafwStatusElement_GetStatusInfo;
        {-}
      {$IfNDef NoVCM}
      // IvcmState
      function SaveState(out theState : IUnknown;
                         aStateType   : TvcmStateType): Boolean;
        {-}
      function LoadState(const aState : IUnknown;
                         aStateType   : TvcmStateType): Boolean;
        {-}
      {$EndIf NoVCM}
    protected
    // internal methods
      {$IfNDef NoVCM}
      function  CheckCurrentPage(const aParams: IvcmExecuteParamsPrim): TPoint;
        {-}
      {$EndIf  NoVCM}  
  end;//TeeCustomPreviewPanel

  TeePreviewPanel = class(TeeCustomPreviewPanel)
   {* Компонент для Preview. С published свойствами. }
    published
      property Align;
  //    property Alignment;
      property Anchors;
      property AutoSize;
      property BevelInner;
      property BevelOuter;
      property BevelWidth;
      property BiDiMode;
      property BorderWidth;
      property BorderStyle;
      property Caption;
      property Color;
      property Constraints;
      property Ctl3D;
      property UseDockManager default True;
      property DockSite;
      property DragCursor;
      property DragKind;
      property DragMode;
      property Enabled;
  //    property FullRepaint;
      property Font;
  //    property Locked;
      property ParentBiDiMode;
      property ParentColor;
      property ParentCtl3D;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property TabOrder;
      property TabStop;
      property Visible;
      property OnCanResize;
      property OnClick;
      property OnConstrainedResize;
      property OnContextPopup;
      property OnDockDrop;
      property OnDockOver;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDock;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnGetSiteInfo;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnResize;
      property OnStartDock;
      property OnStartDrag;
      property OnUnDock;

      property OnCurrentPageChanged;
       {-}
  end;//TeePreviewPanel

{$IfNDef evRunTime}
procedure Register;
{$EndIf evRunTime}

implementation

{$R *.res}

uses
  SysUtils,

  l3Base,
  l3String,
  
  afwFacade,
  
  evInternalInterfaces,
  evConst,
  nevInterfaces,

  vcmDefaultOperations
  ;

// start class TeeCustomPreviewPanel

function TeeCustomPreviewPanel.PreviewGetTarget(const aPt     : TPoint;
                                                out theTarget : IUnknown): Boolean;
  {-}
begin
 Result := true;
 theTarget := GetState;
end;

{$IfNDef NoVCM}
procedure TeeCustomPreviewPanel.opZoomWidth(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 with CheckCurrentPage(aParams) do
  ZoomToPage(Y, X, true);
end;

procedure TeeCustomPreviewPanel.testZoomWidth(const aParams: IvcmTestParamsPrim);
  {-}
begin
 aParams.Op.Flag[vcm_ofEnabled] := IsReady;
 aParams.Op.Flag[vcm_ofChecked] := (ZoomStatus = ev_zsByWidth);
end;

procedure TeeCustomPreviewPanel.opZoomPage(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 with CheckCurrentPage(aParams) do
  ZoomToPage(Y, X, false);
end;

procedure TeeCustomPreviewPanel.testZoomPage(const aParams: IvcmTestParamsPrim);
  {-}
begin
 aParams.Op.Flag[vcm_ofEnabled] := IsReady;
 aParams.Op.Flag[vcm_ofChecked] := (ZoomStatus = ev_zsToPage);
end;

procedure TeeCustomPreviewPanel.opGray(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 GrayscaleFlag := not GrayscaleFlag;
end;

procedure TeeCustomPreviewPanel.testGray(const aParams: IvcmTestParamsPrim);
  {-}
begin
 aParams.Op.Flag[vcm_ofChecked] := not GrayscaleFlag;
end;

procedure TeeCustomPreviewPanel.opInfo(const aParams: IvcmExecuteParamsPrim);
  {-}
var
 l_Preview : IafwComplexDocumentPreview;
begin
 LockGrayScale;
 try
  if (Preview <> nil) then
  begin
   if Supports(Preview, IafwComplexDocumentPreview, l_Preview) then
    try
     with l_Preview do
     begin
      if (ContentKind = afw_pckInfo) then
       ContentKind := afw_pckDocument
      else
       ContentKind := afw_pckInfo
     end;//with l_Preview
    finally
     l_Preview := nil;
    end;//try..finally
  end;//Preview <> nil
 finally
  UnlockGrayScale;
 end;
end;

procedure TeeCustomPreviewPanel.testInfo(const aParams: IvcmTestParamsPrim);
  {-}
var
 l_Preview : IafwComplexDocumentPreview;
begin
 if (Preview <> nil)then
 begin
  if Supports(Preview, IafwComplexDocumentPreview, l_Preview) then
   try
    aParams.Op.Flag[vcm_ofEnabled] := IsReady and (l_Preview.Info <> nil);
    aParams.Op.Flag[vcm_ofChecked] := l_Preview.ContentKind = afw_pckInfo; 
   finally                        
    l_Preview := nil;
   end//try..finally
  else
  begin
   aParams.Op.Flag[vcm_ofEnabled] := false;
   aParams.Op.Flag[vcm_ofChecked] := false;
  end;//Supports(Preview, IafwComplexDocumentPreview, l_Preview)
 end
 else
 begin
  aParams.Op.Flag[vcm_ofEnabled] := false;
  aParams.Op.Flag[vcm_ofChecked] := false;
 end;//Preview <> nil 
end;

procedure TeeCustomPreviewPanel.opFull(const aParams: IvcmExecuteParamsPrim);
  {-}
var
 l_Preview : IafwComplexDocumentPreview;
begin
 LockGrayScale;
 try
  if (Preview <> nil) then
  begin
   if Supports(Preview, IafwComplexDocumentPreview, l_Preview) then
    try
     with l_Preview do
     begin
      if (ContentKind = afw_pckSelection) then
       ContentKind := afw_pckDocument
      else
       ContentKind := afw_pckSelection;
     end;//with l_Preview
    finally
     l_Preview := nil;
    end;//try..finally
  end;//Preview <> nil
 finally
  UnlockGrayScale;
 end;
end;

procedure TeeCustomPreviewPanel.testFull(const aParams: IvcmTestParamsPrim);
  {-}
var
 l_Preview : IafwComplexDocumentPreview;
begin
 if (Preview <> nil) then
 begin
  if Supports(Preview, IafwComplexDocumentPreview, l_Preview) then
   try
    aParams.Op.Flag[vcm_ofEnabled] := IsReady and (l_Preview.Selection <> nil);
    aParams.Op.Flag[vcm_ofChecked] := l_Preview.ContentKind = afw_pckSelection; 
   finally
    l_Preview := nil;
   end//try..finally
  else
  begin
   aParams.Op.Flag[vcm_ofEnabled] := false;
   aParams.Op.Flag[vcm_ofChecked] := false;
  end;//Supports(Preview, IafwComplexDocumentPreview, l_Preview)
 end
 else
 begin
  aParams.Op.Flag[vcm_ofEnabled] := false;
  aParams.Op.Flag[vcm_ofChecked] := false;
 end;//Preview <> nil
end;

procedure TeeCustomPreviewPanel.opZoomIn(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 ZoomIn;
end;

procedure TeeCustomPreviewPanel.opZoomOut(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 ZoomOut;
end;

procedure TeeCustomPreviewPanel.opPrint(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 Print;
end;

procedure TeeCustomPreviewPanel.opPrintDialog(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 if (afw.Application <> nil) AND (afw.Application.PrintManager <> nil) then
  afw.Application.PrintManager.PrintDialog(Preview);
end;
  
procedure TeeCustomPreviewPanel.testReady(const aParams: IvcmTestParamsPrim);
  {-}
begin
 aParams.Op.Flag[vcm_ofEnabled] := IsReady;
end;

procedure TeeCustomPreviewPanel.testCanPrint(const aParams: IvcmTestParamsPrim);
  {-}
begin
 testReady(aParams);
 if aParams.Op.Flag[vcm_ofEnabled] then
  if (afw.Application = nil) OR (afw.Application.PrintManager = nil) OR
     not afw.Application.PrintManager.CanPrint OR
     (Preview = nil) OR (Preview.Printer = nil) OR
     Preview.InProcess or not Preview.Printer.HasPrinter then
   aParams.Op.Flag[vcm_ofEnabled] := false;
end;

procedure TeeCustomPreviewPanel.ProvideOps(const aPublisher: IvcmOperationsPublisher);
  {* - предоставить список доступных операций. }
begin
 with aPublisher do
 begin
  PublishEntity(vcm_dePreview, PreviewGetTarget);
  PublishOp(vcm_dePreview, vcm_doZoomWidth, opZoomWidth, testZoomWidth);
  PublishOp(vcm_dePreview, vcm_doZoomPage, opZoomPage, testZoomPage);
  PublishOp(vcm_dePreview, vcm_doZoomIn, opZoomIn, testReady);
  PublishOp(vcm_dePreview, vcm_doZoomOut, opZoomOut, testReady);
  PublishOp(vcm_deDocument, vcm_doRGBGrayscaleSwitch, opGray, testGray);
  PublishOp(vcm_deDocument, vcm_doPrintInfoSwitch, opInfo, testInfo);
  PublishOp(vcm_deDocument, vcm_doFullSelectedSwitch, opFull, testFull);
  PublishOp(vcm_deFile, vcm_doPrint, opPrint, testCanPrint);
  PublishOp(vcm_deFile, vcm_doPrintDialog, opPrintDialog, testCanPrint);
 end;//with aPublisher
end;
{$EndIf NoVCM}
  
procedure TeeCustomPreviewPanel.IafwStatusElement_GetStatusInfo(out theString: Il3CString; out theNeedProgress: Boolean);
var
 l_Count  : Integer;
begin
 theString := nil;
 theNeedProgress := False;
 if not IsPagesCounter AND not InUpdate then
 begin
  //l_Count := PagesCount;
  l_Count := PagesCounted.rOverallPagesCount;
(*  if (l_Count > 0) then
  begin
   with CurrentPage do
    theString := l3Fmt(str_nevmmPageCounter.AsCStr, [Y + 1, l_Count]);
  end;//l_Count > 0*)
  if (l_Count > 0) then
  begin
   //with CurrentPage do
    theString := l3Fmt(str_nevmmPageCounterNew.AsCStr, [l_Count]);
  end;//l_Count > 0
 end;//not IsPagesCounter..
end;

{$IfNDef NoVCM}
function TeeCustomPreviewPanel.SaveState(out theState : IUnknown;
                                         aStateType   : TvcmStateType): Boolean;
  {-}
begin
 Result := true;
 Case aStateType of
  vcm_stContent :
   theState := GetState;
  else
   Result := false;
 end;//Case aStateType
end;

function TeeCustomPreviewPanel.LoadState(const aState : IUnknown;
                                         aStateType   : TvcmStateType): Boolean;
  {-}
var
 l_State : IevPreviewPanelState;  
begin
 Result := true;
 Case aStateType of
  vcm_stContent :
   if Supports(aState, IevPreviewPanelState, l_State) then
    try
     SetState(l_State);
    finally
     l_State := nil;
    end//try..finally
   else
    Result := false;
  else
   Result := false;
 end;//Case aStateType
end;

function TeeCustomPreviewPanel.CheckCurrentPage(const aParams: IvcmExecuteParamsPrim): TPoint;
  {-}
var
 l_State : IevPreviewPanelState;
begin
 if (aParams <> nil) AND
    Supports(aParams.Target, IevPreviewPanelState, l_State) then
  try
   Result := l_State.Page;
   Exit;
  finally
   l_State := nil;
  end;//try..finally
 CurrentPage := DefPage;
 Result := CurrentPage;
end;
{$EndIf NoVCM}

{$IfNDef evRunTime}
procedure Register;
begin
  RegisterComponents(evEverestPage, [TeePreviewPanel]);
end;
{$EndIf evRunTime}

end.
