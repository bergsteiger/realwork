unit evEditorWithOperations;
{* Редактор, поддерживающий операции для VCM. }

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evEditorWithOperations - }
{ Начат: 25.11.2004 11:08 }
{ $Id: evEditorWithOperations.pas,v 1.36 2015/07/01 08:44:23 kostitsin Exp $ }

// $Log: evEditorWithOperations.pas,v $
// Revision 1.36  2015/07/01 08:44:23  kostitsin
// {requestlink: 602940683 }
//
// Revision 1.35  2015/06/19 12:54:39  kostitsin
// {requestlink: 602012522 }
//
// Revision 1.34  2012/10/26 14:54:54  lulin
// {RequestLink:406489593}
//
// Revision 1.33  2012/10/26 14:08:43  lulin
// {RequestLink:406489593}
//
// Revision 1.32  2010/06/28 16:39:13  lulin
// {RequestLink:220594770}.
//
// Revision 1.31  2010/03/16 15:20:43  lulin
// {RequestLink:196968958}.
// [$197496559].
//
// Revision 1.30  2009/12/22 10:19:21  lulin
// {RequestLink:175014361}.
//
// Revision 1.29  2009/08/07 11:00:57  lulin
// - убираем ненужные операции.
//
// Revision 1.28  2009/07/10 16:15:41  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.27  2009/07/08 14:23:49  lulin
// - чистим контекст.
//
// Revision 1.26  2009/05/29 17:18:25  lulin
// [$142610853].
//
// Revision 1.25  2009/03/06 10:20:47  lulin
// - <K>: 138549392. Не считаем шрифт, если ткнули не в комментарий.
//
// Revision 1.24  2008/10/01 10:49:49  lulin
// - <K>: 120718563.
//
// Revision 1.23  2008/09/30 18:13:57  lulin
// - <K>: 120718561.
//
// Revision 1.22  2008/04/11 12:26:08  lulin
// - <K>: 89100752.
//
// Revision 1.21  2008/04/02 17:29:36  lulin
// - удалён ненужныё фасет.
//
// Revision 1.20  2008/04/02 14:22:01  lulin
// - cleanup.
//
// Revision 1.19  2007/12/05 12:35:06  lulin
// - вычищен условный код, составлявший разницу ветки и Head'а.
//
// Revision 1.18  2007/12/04 13:04:55  lulin
// - объединяем два каталога с исходниками Эвереста.
//
// Revision 1.4  2007/09/18 16:58:03  lulin
// - cleanup.
//
// Revision 1.3  2007/01/20 15:30:58  lulin
// - разделяем параметры операции для выполнения и для тестирования.
//
// Revision 1.2  2007/01/18 11:18:01  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.1  2007/01/18 10:51:22  lulin
// - модуль переехал в общую папку.
//
// Revision 1.16.2.31  2007/01/17 17:53:33  lulin
// - сужаем список параметров для тестирования операции.
//
// Revision 1.16.2.30  2007/01/17 14:02:37  lulin
// - вычищены последние нефиксированные параметры в тестах операций.
//
// Revision 1.16.2.29  2006/07/20 18:28:06  lulin
// - убран лишний параметр.
//
// Revision 1.16.2.28  2006/07/20 17:35:57  lulin
// - убраны параметры по умолчанию.
// - имя метода убрано из комментариев.
// - bug fix: в КЗ - рисовался "палец", теперь он правда рисуется в другом месте.
//
// Revision 1.16.2.27  2006/07/04 10:51:14  oman
// - fix: Если контрол публикует операцию, то он должен перестать
//  обрабатывать соответствующую команду.
//
// Revision 1.16.2.26  2006/07/03 14:05:55  oman
// - fix: Была неправильная проверка в OnTest (cq21575)
// - fix: Более аккуратная поддержка WordLeft и WordRight по ctrl+alt+стрелки (cq21546)
//
// Revision 1.16.2.25  2006/07/03 13:31:21  lulin
// - bug fix: проверка доступности Undo/Redo была НЕПРАВИЛЬНАЯ. Убрана (CQ OIT5-21585).
//
// Revision 1.16.2.24  2006/07/03 10:56:07  oman
// - new beh: Публикуем операции WordLeft и WordRight (cq21546)
//
// Revision 1.16.2.23  2006/06/27 08:18:04  oman
// - fix: OnTest операции не учитывало ReadOnly редактора (cq21475)
//
// Revision 1.16.2.22  2006/06/21 14:20:31  lulin
// - выделен виртуальный метод - определяющий доступна операция "вырезать" или нет.
//
// Revision 1.16.2.21  2006/06/21 13:36:25  oman
// - fix: Не собиралась библиотека
//
// Revision 1.16.2.20  2006/06/21 09:09:52  oman
// - fix: Если опубликовали операцию, то давим обработку команд от
//  шорткатов (cq21215)
//
// Revision 1.16.2.19  2006/05/23 09:42:38  mmorozov
// - change: присечены последние попытки устанавливать ProvideOperations неправильным способом (вылезали не нужные операции);
//
// Revision 1.16.2.18  2006/05/18 10:51:06  mmorozov
// - new: компоненты с разным набором операций;
//
// Revision 1.16.2.17  2006/04/27 07:59:18  lulin
// - правильным образом не публикуем ненужные операции в КЗ.
//
// Revision 1.16.2.16  2006/02/15 09:35:28  mmorozov
// - change: в методе testCut;
//
// Revision 1.16.2.15  2006/02/14 17:05:25  dinishev
// Cleanup
//
// Revision 1.16.2.14  2006/02/14 10:45:24  mmorozov
// no message
//
// Revision 1.16.2.13  2006/02/14 10:44:52  mmorozov
// - new: обработчики для операции "Вырезать";
//
// Revision 1.16.2.12  2006/02/10 06:50:56  mmorozov
// - не собирался проект;
//
// Revision 1.16.2.11  2005/12/01 06:10:34  lulin
// - интерфейс _preview перенесен в более общую библиотеку.
//
// Revision 1.16.2.10  2005/11/30 16:25:38  mmorozov
// - new: перечислимый тип операций которые должен публиковать редактор;
//
// Revision 1.16.2.9  2005/11/23 16:52:50  dinishev
// Прячем операции с печатью для КЗ
//
// Revision 1.16.2.8  2005/11/02 12:30:40  lulin
// - уменьшаем количество вызовов методов для анализа параметров шрифта.
//
// Revision 1.16.2.7  2005/10/13 10:41:09  lulin
// - получаем _Loader у контейнера документа, а не через цепочку Parent'ов.
//
// Revision 1.16.2.6  2005/09/22 08:06:11  lulin
// - при определении возможности печати учитываем триальный режим или нет.
//
// Revision 1.16.2.5  2005/08/30 14:12:52  lulin
// - сделано выделение только параграфа.
//
// Revision 1.16.2.4  2005/08/29 11:52:43  lulin
// - свойство PlainText переехало на базовый редактор.
//
// Revision 1.16.2.3  2005/07/25 18:09:16  lulin
// - теперь TextSource не знает про реализацию контейнера документа, а только про его интерфейс.
//
// Revision 1.16.2.2  2005/06/01 16:22:24  lulin
// - remove unit: evIntf.
//
// Revision 1.16.2.1  2005/05/18 12:42:46  lulin
// - отвел новую ветку.
//
// Revision 1.13.4.1  2005/05/18 12:32:08  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.16  2005/05/17 11:19:24  lulin
// - cleanup: возвращаем более общий интерфейс.
//
// Revision 1.15  2005/05/12 10:35:14  mmorozov
// new behaviour: кнопки "Печать", "Диалог печати", "Предварительный просмотр" не доступны если в системе не ни одного принтера;
//
// Revision 1.14  2005/05/05 13:00:19  demon
// - fix: операции объявленные на редакторе не реагировали на Exclude Usertype.
// В их OnTest добавлено условие if aParams._asBool[vcm_opEnabled] then тогда проверяем внутренние условия.
//
// Revision 1.13  2005/01/27 09:15:19  lulin
// - new behavior: вне коментария не показываем контекстную операцию "Поставить ссылку".
//
// Revision 1.12  2005/01/27 08:42:04  lulin
// - new behavior: не показываем операции с коментариями в контекстном меню, если они недоступны пользователю.
//
// Revision 1.11  2005/01/26 17:54:11  lulin
// - подготовил почву для убирания операций с комментариями из контекстного меню.
//
// Revision 1.10  2005/01/21 11:31:52  lulin
// - new behavior: операция "Выделить все" недоступна, если выделен документ целиком.
//
// Revision 1.9  2005/01/19 10:50:41  lulin
// - new prop: TevCustomEditor.IsStaticText.
//
// Revision 1.8  2005/01/12 12:47:32  lulin
// - перевел модуль afwFacade в глобальных процедур на метакласс.
//
// Revision 1.7  2004/12/30 14:47:17  lulin
// - TevEditorWithOperations теперь поддерживает операции печати.
//
// Revision 1.6  2004/11/25 10:21:10  lulin
// - метод TevEditorWithOperations.ProvideOps сделан виртуальным.
//
// Revision 1.5  2004/11/25 09:39:24  lulin
// - убран лишний параметр aContext - т.к. он вычисляется из aParams._Target.
//
// Revision 1.4  2004/11/25 08:33:52  lulin
// - перенес поддержку операций с TnscEditor на TevEditorWithOperations.
//
// Revision 1.3  2004/11/25 08:23:54  lulin
// - new prop: TevEditorWithOperations.PlainText.
//
// Revision 1.2  2004/11/25 08:14:49  lulin
// - добавлен комментарий.
//
// Revision 1.1  2004/11/25 08:12:21  lulin
// - new unit: evEditorWithOperations.
//

{$Include evDefine.inc }

interface

uses
  Classes,
  Types,

  l3Types,
  l3InternalInterfaces,

  evInternalInterfaces,
  evTypes,

  {$IfNDef NoVCM}
  vcmExternalInterfaces,
  {$EndIf  NoVCM}

  evCustomEditor
  ;

type
  TevEditorProvideOperationType = (
  {* Операции которые публикует редактор. }
   potEdit,
     // редактирование текста
   potTable,
     // работа с таблицами
   potFontStyle,                                                  
     // стиль текста
   potPrint,
     // операции печати
   potText
  );

  TevEditorProvideOperationTypes = set of TevEditorProvideOperationType;

  TevEditorWithOperations = class(TevCustomEditor,
                                  {$IfNDef NoVCM}
                                  IvcmOperationsProvider,
                                  {$EndIf  NoVCM}
                                  Il3CommandPublisherInfo)
   {* Редактор, поддерживающий операции для VCM. }
    private
    // property fields
      f_ProvideOperationTypes: TevEditorProvideOperationTypes;
      f_Published: Boolean;
    protected
    // operations handlers
     function IsCommandPublished(Cmd: Tl3OperationCode): Boolean;
        virtual;
      {-}
      function DefineProvideOperations: TevEditorProvideOperationTypes;
        virtual;
        {* - Какие операции публикуются компонентом. }
      {$IfNDef NoVCM}
      function TextGetTarget(const aPt     : TPoint;
                             out theTarget : IUnknown): Boolean;
        virtual;
        {-}
      procedure opSelectAll(const aParams: IvcmExecuteParamsPrim);
        virtual;
        {-}
      procedure testSelectAll(const aParams: IvcmTestParamsPrim);
        virtual;
        {-}
      procedure opDeselect(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opPaste(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opCopy(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opCut(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opUndo(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opRedo(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opInsertTable(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opInsertRow(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opDeleteRow(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opInsertColumn(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opDeleteColumn(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opBold(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opItalic(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opUnderline(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opStrikeout(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opPrint(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opPrintDialog(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opPrintPreview(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opWordLeft(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure opWordRight(const aParams: IvcmExecuteParamsPrim);
        {-}
      procedure testPreview(const aParams: IvcmTestParamsPrim);
        virtual;
        {-}
      procedure testPrint(const aParams: IvcmTestParamsPrim);
        virtual;
        {-}
      procedure testPaste(const aParams: IvcmTestParamsPrim);
        {-}
      procedure testUndo(const aParams: IvcmTestParamsPrim);
        {-}
      procedure testRedo(const aParams: IvcmTestParamsPrim);
        {-}
      procedure testHasSelecion(const aParams: IvcmTestParamsPrim);
        {-}
      procedure testCopy(const aParams: IvcmTestParamsPrim);
        {-}
      procedure testCut(const aParams: IvcmTestParamsPrim);
        {-}
      procedure CheckTarget(const aParams: IvcmTestParamsPrim);
        {-}
      function  testReadOnlyPrim(const aParams: IvcmTestParamsPrim): Boolean;
        {-}
      procedure testReadOnly(const aParams: IvcmTestParamsPrim);
        {-}
      procedure testInTable(const aParams: IvcmTestParamsPrim);
        {-}
      procedure testBold(const aParams: IvcmTestParamsPrim);
        {-}
      procedure testItalic(const aParams: IvcmTestParamsPrim);
        {-}
      procedure testUnderline(const aParams: IvcmTestParamsPrim);
        {-}
      procedure testStrikeOut(const aParams: IvcmTestParamsPrim);
        {-}
      {$EndIf  NoVCM}  
    protected
    // interface methods
      {$IfNDef NoVCM}
      function  CanCut: Boolean;
        virtual;
        {-}
      procedure ProvideOps(const aPublisher: IvcmOperationsPublisher);
        virtual;
        {* - предоставить список доступных операций. }
      {$EndIf  NoVCM}  
      {$IfDef evNeedDisp}
      function Process(Sender : TObject;
                       aTarget : TObject;
                       Action : Long;
                       Down   : Bool): Bool;
       override;
        {-}
      {$EndIf evNeedDisp}
    public
    // public methods
      constructor Create(AOwner: TComponent);
        override;
        {-}
      function  IsReadOnlyTarget(const aTarget: IUnknown): Boolean;
        virtual;
        {-}
      property ProvideOperationTypes: TevEditorProvideOperationTypes
        read f_ProvideOperationTypes
        write f_ProvideOperationTypes;  
  end;//TevEditorWithOperations

implementation

uses
  SysUtils,
  Printers,

  Clipbrd,

  OvcConst,

  afwInterfaces,
  afwFacade,

  nevTools,
  
  evEditorWindow,
  evStandardActions,
  evOp,
  nevGUIInterfaces

  {$IfNDef NoVCM}
  ,
  vcmDefaultOperations
  {$EndIf  NoVCM}
  ;

const
  c_evDefaultProvideOperationTypes : TevEditorProvideOperationTypes =
   {* Публикуемые операции по умолчанию. }
   [potEdit, potTable, potFontStyle, potPrint, potText];

// start class TevEditorWithOperations

{$IfNDef NoVCM}
procedure TevEditorWithOperations.ProvideOps(const aPublisher: IvcmOperationsPublisher);
  {* - предоставить список доступных операций. }
begin
 f_Published := true;
 with aPublisher do
 begin
  if potText in f_ProvideOperationTypes then
  begin
   PublishEntity(vcm_deText, TextGetTarget);
   PublishOp(vcm_deText, vcm_doWordLeft, opWordLeft, nil);
   PublishOp(vcm_deText, vcm_doWordRight, opWordRight, nil);
  end;
  if potEdit in f_ProvideOperationTypes then
  begin
   PublishEntity(vcm_deEdit, TextGetTarget);
   PublishOp(vcm_deEdit, vcm_doSelectAll, opSelectAll, testSelectAll);
   PublishOp(vcm_deEdit, vcm_doDeselect, opDeselect, testHasSelecion);
   if not IsStaticText then
    PublishOp(vcm_deEdit, vcm_doCut, opCut, testCut);
   PublishOp(vcm_deEdit, vcm_doCopy, opCopy, testCopy);
   if not IsStaticText then
    PublishOp(vcm_deEdit, vcm_doPaste, opPaste, testPaste);
   if not IsStaticText then
   begin
    PublishOp(vcm_deEdit, vcm_doUndo, opUndo, testUndo);
    PublishOp(vcm_deEdit, vcm_doRedo, opRedo, testRedo);
   end;//not IsStaticText
  end;//if eotText in f_ProvideOperationTypes then
  if not PlainText then
  begin
   if not IsStaticText then
   begin
    if potTable in f_ProvideOperationTypes then
    begin
     PublishEntity(vcm_deTable, TextGetTarget);
     PublishOp(vcm_deTable, vcm_doInsert, opInsertTable, testReadOnly);
     PublishOp(vcm_deTable, vcm_doInsertRow, opInsertRow, testInTable);
     PublishOp(vcm_deTable, vcm_doDeleteRow, opDeleteRow, testInTable);
     PublishOp(vcm_deTable, vcm_doInsertColumn, opInsertColumn, testInTable);
     PublishOp(vcm_deTable, vcm_doDeleteColumn, opDeleteColumn, testInTable);
    end;//if potTable in f_ProvideOperationTypes then
    if potFontStyle in f_ProvideOperationTypes then
    begin
     PublishEntity(vcm_deFont, TextGetTarget);
     PublishOp(vcm_deFont, vcm_doBold, opBold, testBold);
     PublishOp(vcm_deFont, vcm_doItalic, opItalic, testItalic);
     PublishOp(vcm_deFont, vcm_doUnderline, opUnderline, testUnderline);
     PublishOp(vcm_deFont, vcm_doStrikeout, opStrikeout, testStrikeout);
    end;//if potFontStyle in f_ProvideOperationTypes then
   end;//not IsStaticText
  end;//not PlainText
  if potPrint in f_ProvideOperationTypes then
  begin
   PublishEntity(vcm_deFile, TextGetTarget);
   PublishOp(vcm_deFile, vcm_doPrint, opPrint, testPrint);
   PublishOp(vcm_deFile, vcm_doPrintDialog, opPrintDialog, testPrint);
   PublishOp(vcm_deFile, vcm_doPrintPreview, opPrintPreview, testPreview);
  end;//if potTable in f_ProvideOperationTypes then
 end;//with aPublisher
end;//ProvideOps
{$EndIf  NoVCM}

function TevEditorWithOperations.DefineProvideOperations: TevEditorProvideOperationTypes;
  // virtual;
  {* - Определим публикуемые операции. }
begin
 Result := c_evDefaultProvideOperationTypes;
end;//DefineProvideOperations

{$IfNDef NoVCM}
function TevEditorWithOperations.TextGetTarget(const aPt     : TPoint;
                                               out theTarget : IUnknown): Boolean;
  //virtual;
  {-}
begin
 Result := GetHotspotOnPoint(aPt, IevHotSpot(theTarget), false);
end;

procedure TevEditorWithOperations.opSelectAll(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 Select(ev_stDocument);
end;

procedure TevEditorWithOperations.testSelectAll(const aParams: IvcmTestParamsPrim);
  {-}
begin
 if aParams.Op.Flag[vcm_ofEnabled] then
  if not HasDocument or (Selection = nil) OR (Selection.Collapsed) then
   aParams.Op.Flag[vcm_ofEnabled] := true
  else
   aParams.Op.Flag[vcm_ofEnabled] := not InevSelection(Selection).GetBlock.Solid(View);
end;

procedure TevEditorWithOperations.opDeselect(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 if (Selection <> nil) then
  InevSelection(Selection).Unselect;
end;

procedure TevEditorWithOperations.opPaste(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 Paste;
end;

procedure TevEditorWithOperations.opCopy(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 Copy;
end;

procedure TevEditorWithOperations.opCut(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 Cut;
end;

procedure TevEditorWithOperations.opUndo(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 Processor.Undo;
end;

procedure TevEditorWithOperations.opRedo(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 Processor.Redo;
end;

procedure TevEditorWithOperations.opInsertTable(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 InsertTable(3, 3);
end;
  
procedure TevEditorWithOperations.opInsertRow(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 InsertRow;
end;

procedure TevEditorWithOperations.opDeleteRow(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 DeleteRow;
end;

procedure TevEditorWithOperations.opInsertColumn(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 InsertColumn;
end;

procedure TevEditorWithOperations.opDeleteColumn(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 DeleteColumn;
end;

procedure TevEditorWithOperations.opBold(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 {$IfNDef DesignTimeLibrary}
 with TextPara.Font do
  Bold := not Bold;
 {$EndIf  DesignTimeLibrary}
end;

procedure TevEditorWithOperations.opItalic(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 {$IfNDef DesignTimeLibrary}
 with TextPara.Font do
  Italic := not Italic;
 {$EndIf  DesignTimeLibrary}
end;

procedure TevEditorWithOperations.opUnderline(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 {$IfNDef DesignTimeLibrary}
 with TextPara.Font do
  Underline := not Underline;
 {$EndIf  DesignTimeLibrary}
end;

procedure TevEditorWithOperations.opStrikeout(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 {$IfNDef DesignTimeLibrary}
 with TextPara.Font do
  StrikeOut := not StrikeOut;
 {$EndIf  DesignTimeLibrary}
end;

procedure TevEditorWithOperations.opPrint(const aParams: IvcmExecuteParamsPrim);
  {-}
var
 l_Preview : IafwComplexDocumentPreview;  
begin
 l_Preview := Preview;
 if (l_Preview <> nil) then
  l_Preview.Print;
end;

procedure TevEditorWithOperations.opPrintDialog(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 if (afw.Application <> nil) AND (afw.Application.PrintManager <> nil) then
  afw.Application.PrintManager.PrintDialog(Preview);
end;

procedure TevEditorWithOperations.opPrintPreview(const aParams: IvcmExecuteParamsPrim);
  {-}
begin
 if (afw.Application <> nil) AND (afw.Application.PrintManager <> nil) then
  afw.Application.PrintManager.ShowPreview(Preview);
end;

procedure TevEditorWithOperations.testPrint(const aParams: IvcmTestParamsPrim);
  {-}
begin
 testPreview(aParams);
 if aParams.Op.Flag[vcm_ofEnabled] then
  if (afw.Application = nil) OR (afw.Application.PrintManager = nil) OR
     not afw.Application.PrintManager.CanPrint then
   aParams.Op.Flag[vcm_ofEnabled] := false;
end;

procedure TevEditorWithOperations.testPreview(const aParams: IvcmTestParamsPrim);
  {-}
begin
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := (Printer.Printers.Count > 0) AND HasDocument
   AND not TextSource.DocumentContainer.Loading;
end;

procedure TevEditorWithOperations.testPaste(const aParams: IvcmTestParamsPrim);
  {-}
begin
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := not IsStaticText and (Clipboard.FormatCount > 0);
end;

procedure TevEditorWithOperations.testUndo(const aParams: IvcmTestParamsPrim);
  {-}
begin
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := Processor.CanUndo;
end;

procedure TevEditorWithOperations.testRedo(const aParams: IvcmTestParamsPrim);
  {-}
begin
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := Processor.CanRedo;
end;

procedure TevEditorWithOperations.testHasSelecion(const aParams: IvcmTestParamsPrim);
  {-}
begin
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := HasSelection;
end;

function TevEditorWithOperations.CanCut: Boolean;
  //virtual;
  {-}
begin
 Result := not IsReadOnly and HasSelection;
end;

procedure TevEditorWithOperations.testCut(const aParams: IvcmTestParamsPrim);
  {-}
begin
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := HasDocument and CanCut;
end;

procedure TevEditorWithOperations.testCopy(const aParams: IvcmTestParamsPrim);
  {-}
begin
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := HasSelection OR InBitmap;
end;
{$EndIf  NoVCM}

constructor TevEditorWithOperations.Create(AOwner: TComponent);
  // override;
  {-}
begin
 inherited;
 f_ProvideOperationTypes := DefineProvideOperations;
end;

function TevEditorWithOperations.IsReadOnlyTarget(const aTarget: IUnknown): Boolean;
  //virtual;
  {-}
begin
 Result := not CanUserModify;
end;

{$IfNDef NoVCM}
procedure TevEditorWithOperations.CheckTarget(const aParams: IvcmTestParamsPrim);
  {-}
begin
 if (aParams.Target <> nil) then
  aParams.Op.Flag[vcm_ofVisible] := not IsReadOnlyTarget(aParams.Target);
end;

function TevEditorWithOperations.testReadOnlyPrim(const aParams: IvcmTestParamsPrim): Boolean;
  {-}
begin
 if aParams.Op.Flag[vcm_ofEnabled] then
 begin
  CheckTarget(aParams);
  aParams.Op.Flag[vcm_ofEnabled] := not ReadOnly;
  Result := aParams.Op.Flag[vcm_ofVisible] AND aParams.Op.Flag[vcm_ofEnabled];
 end//aParams.Op.Flag[vcm_ofEnabled]
 else
  Result := false;
end;

procedure TevEditorWithOperations.testReadOnly(const aParams: IvcmTestParamsPrim);
  {-}
begin
 testReadOnlyPrim(aParams);
end;

procedure TevEditorWithOperations.testInTable(const aParams: IvcmTestParamsPrim);
  {-}
begin
 if aParams.Op.Flag[vcm_ofEnabled] then
 begin
  CheckTarget(aParams);
  aParams.Op.Flag[vcm_ofEnabled] := InTable AND not ReadOnly;
 end;//aParams.Op.Flag[vcm_ofEnabled]
end;

procedure TevEditorWithOperations.testBold(const aParams: IvcmTestParamsPrim);
  {-}
begin
 {$IfNDef DesignTimeLibrary}
 aParams.Op.Flag[vcm_ofChecked] := testReadOnlyPrim(aParams) AND TextPara.Font.Bold;
 {$EndIf DesignTimeLibrary}
end;

procedure TevEditorWithOperations.testItalic(const aParams: IvcmTestParamsPrim);
  {-}
begin
 {$IfNDef DesignTimeLibrary}
 aParams.Op.Flag[vcm_ofChecked] := testReadOnlyPrim(aParams) AND TextPara.Font.Italic;
 {$EndIf DesignTimeLibrary}
end;

procedure TevEditorWithOperations.testUnderline(const aParams: IvcmTestParamsPrim);
  {-}
begin
 {$IfNDef DesignTimeLibrary}
 aParams.Op.Flag[vcm_ofChecked] := testReadOnlyPrim(aParams) AND TextPara.Font.Underline;
 {$EndIf DesignTimeLibrary}
end;

procedure TevEditorWithOperations.testStrikeOut(const aParams: IvcmTestParamsPrim);
  {-}
begin
 {$IfNDef DesignTimeLibrary}
 aParams.Op.Flag[vcm_ofChecked] := testReadOnlyPrim(aParams) AND TextPara.Font.Strikeout;
 {$EndIf DesignTimeLibrary}
end;
{$EndIf NoVCM}

{$IfDef evNeedDisp}
function TevEditorWithOperations.Process(Sender, aTarget: TObject;
  Action: Long; Down: Bool): Bool;
begin
 if f_Published then
  case TevOperation(Action) of
   ev_ccSelectAll,
   ev_ccHideSelection,
   ev_ccCopy,
   ev_ccUndo,
   ev_ccRedo:
    if potEdit in f_ProvideOperationTypes then
     Result := False
    else
     Result := inherited Process(Sender, aTarget, Action, Down);
   ev_ccCut,
   ev_ccPaste:
    if (potEdit in f_ProvideOperationTypes) and not IsStaticText then
     Result := False
    else
     Result := inherited Process(Sender, aTarget, Action, Down);
   ev_ccInsertTable,
   ev_ccInsertRow,
   ev_ccDeleteRow,
   ev_ccInsertColumn,
   ev_ccDeleteColumn:
    if (potTable in f_ProvideOperationTypes) and not (PlainText or IsStaticText) then
     Result := False
    else
     Result := inherited Process(Sender, aTarget, Action, Down);
   ev_ccItalic,
   ev_ccUnderLine,
   ev_ccStrikeOut:
    if (potFontStyle in f_ProvideOperationTypes) and not (PlainText or IsStaticText) then
     Result := False
    else
     Result := inherited Process(Sender, aTarget, Action, Down);
   ev_ccPrint,
   ev_ccPrintEx,
   ev_ccPrintPreview:
    if potPrint in f_ProvideOperationTypes then
     Result := False
    else
     Result := inherited Process(Sender, aTarget, Action, Down);
  else
   Result := inherited Process(Sender, aTarget, Action, Down);
  end
 else
  Result := inherited Process(Sender, aTarget, Action, Down);
end;
{$EndIf evNeedDisp}

{$IfNDef NoVCM}
procedure TevEditorWithOperations.opWordLeft(
  const aParams: IvcmExecuteParamsPrim);
begin
 ProcessCommand(ev_ocWordLeft,True,1);
end;

procedure TevEditorWithOperations.opWordRight(
  const aParams: IvcmExecuteParamsPrim);
begin
 ProcessCommand(ev_ocWordRight,True,1);
end;
{$EndIf  NoVCM}

function TevEditorWithOperations.IsCommandPublished(
  Cmd: Tl3OperationCode): Boolean;
begin
 if f_Published then
  Case Cmd of
   ev_ocWordLeft,
   ev_ocWordRight:
    Result := potText in f_ProvideOperationTypes;
   ccAllSelect,
   ccAllDeselect,
   ev_ocCopy,
   ev_ocUndo,
   ev_ocRedo:
    Result := potEdit in f_ProvideOperationTypes;
   ev_ocCut,
   ev_ocPaste:
    Result := (potEdit in f_ProvideOperationTypes) and not IsStaticText;
   ev_ocInsertRow,
   ev_ocDeleteRow,
   ev_ocInsertColumn,
   ev_ocDeleteColumn:
    Result := (potTable in f_ProvideOperationTypes) and not (PlainText or IsStaticText);
   else
     Result := False;
  end
 else
  Result := False;
end;

end.

