//..........................................................................................................................................................................................................................................................
unit evTuneBlocksDlg;
{* Запрос уровня вложенности блоков в документе }

// $Id: evTuneBlocksDlg.pas,v 1.18 2015/02/02 08:07:21 dinishev Exp $

// $Log: evTuneBlocksDlg.pas,v $
// Revision 1.18  2015/02/02 08:07:21  dinishev
// Обновление эталона.
//
// Revision 1.17  2010/12/10 17:58:11  lulin
// {RequestLink:245761273}.
//
// Revision 1.16  2009/09/02 11:48:49  lulin
// {RequestLink:159360578}. №20.
//
// Revision 1.15  2009/07/14 14:56:35  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.14  2008/09/02 12:38:12  lulin
// - <K>: 88080895.
//
// Revision 1.13  2008/04/09 11:20:26  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.12  2008/03/14 11:38:36  narry
// - более корректная смена статуса кнопок
//
// Revision 1.11  2007/12/26 14:10:31  lulin
// - модуль l3Interfaces полностью переведен на модель.
//
// Revision 1.10  2007/12/26 07:55:31  dinishev
// не компилировалось
//
// Revision 1.9  2007/12/04 12:47:42  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.8  2007/01/19 16:21:26  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.1.2.7  2006/12/21 16:16:44  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.1.2.6  2006/12/10 18:58:57  lulin
// - класс формы переименован в соответствии с библиотекой.
//
// Revision 1.1.2.5  2006/12/05 14:15:34  lulin
// - контрол переехал в визуальную библиотеку.
//
// Revision 1.1.2.4  2006/11/23 10:45:42  dinishev
// Bug fix: не компилировался Everest
//
// Revision 1.1.2.3  2006/10/12 15:14:37  dinishev
// Bug fix: не компилировался Everest
//
// Revision 1.1.2.2  2006/02/08 14:08:28  lulin
// - собрал EverestLite в ветке.
//
// Revision 1.1.2.1  2006/02/08 11:50:26  lulin
// - утилитные файлы для Эвереста переехали в ветку.
//
// Revision 1.22.6.1  2006/02/07 15:16:28  lulin
// - попытка доточить под ветку (пока неудачно).
//
// Revision 1.22  2005/12/01 11:47:08  narry
// - обновление
//
// Revision 1.21  2005/07/28 16:43:53  voba
// no message
//
// Revision 1.20  2005/05/27 14:42:34  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.19  2005/05/16 15:31:16  lulin
// - cleanup: прямое использование объекта заменено на использование интерфейса.
//
// Revision 1.18  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.17  2005/01/14 17:40:47  lulin
// - в ProcessCommand добавлен параметр aForce - сигнализирующий, что такого ShortCut'а нету в VCM и что не надо умничать с обработкой комманды.
//
// Revision 1.16  2004/12/23 11:13:42  lulin
// - rename prop: TvtCustomOutliner.TreeSource -> TreeStruct.
//
// Revision 1.15  2004/12/07 10:18:05  narry
// - bug fix: редактирование структуры разрушало структуру
//
// Revision 1.14  2004/06/30 10:57:18  narry
// - bug fix: не работало перемещение блоков
//
// Revision 1.13  2004/06/17 15:37:47  narry
// - bug fix:удаление последнего блока в структуре не расширяло границы предыдущего
//
// Revision 1.12  2004/06/11 07:54:21  narry
// - update: замена веткой Switch_for_l3Tree
//
// Revision 1.11.2.5  2004/06/11 07:44:36  narry
// - update: перед слиянием с основной веткой
//
// Revision 1.11.2.4  2004/06/09 08:04:08  narry
// - update: обработка сносок, отработка Ctrl-Click
//
// Revision 1.11.2.3  2004/06/03 12:27:10  narry
// - update: новая идеология окна конфигурации
//
// Revision 1.11.2.2  2004/05/28 14:57:55  narry
// - update: не работает
//
// Revision 1.11.2.1  2004/05/21 13:01:13  narry
// - update: комплируется, но работает неправильно
//
// Revision 1.11  2004/05/20 11:38:18  narry
// - update
//
// Revision 1.10  2003/12/01 15:20:34  narry
// - cleanup
// - bug fix: Integer overflow при формировании номера блока глубокой вложенности
// -change: переименование пункта "Произвольно" в "Больше пяти уровней" и перенос его в конец списка
//
// Revision 1.9  2003/11/19 15:44:14  narry
// - bug fix: AV при перемещении узла на место удаленного
// - add: операции с несколькими выделенными узлами
//
// Revision 1.8  2003/11/05 12:20:32  narry
// - bug fix and update
//
// Revision 1.7  2003/11/03 17:16:11  narry
// - bug fix: неверно разбивался документ, содержащий в себе блоки и пустые абзацы между последним блоком и подписью
//
// Revision 1.6  2003/10/31 14:58:16  narry
// - попытка "полюбить" large font
//
// Revision 1.5  2003/10/24 10:43:47  narry
// - bug fix: Примечания поглощали все блоки до конца документа
//
// Revision 1.4  2003/10/20 07:12:54  narry
// - update
//
// Revision 1.3  2003/10/06 10:12:06  narry
// - change: переименование модуля evBseCur в evBaseCursor
//
// Revision 1.2  2003/09/26 14:04:12  narry
// - update
//
// Revision 1.1  2003/09/24 15:29:48  narry
// - update
//
// Revision 1.5.6.3  2003/06/19 15:43:00  narry
// - update: совершенствование настройки дерева блоков документа
//
// Revision 1.5.6.2  2003/06/18 13:58:10  narry
// - update:
//
// Revision 1.5.6.1  2003/06/04 15:40:51  narry
// - not work: съезжают границы блоков, не у всех блоков есть имена
//
// Revision 1.5  2003/04/19 12:30:36  law
// - new file: ddDefine.inc.
//
// Revision 1.4  2003/02/14 11:25:25  narry
// - new behavior: отключение выделения сносок в отдельный блок
//
// Revision 1.3  2002/12/20 14:03:31  narry
// - new behavior: подтверждение слияния идущих друг за другом заголовков
//
// Revision 1.2  2002/11/26 16:28:42  narry
// - update
//
// Revision 1.1  2002/10/22 12:44:23  narry
// - new behavior: расстановка блоков на заданный уровень вложенности
//

{$I ddDefine.inc }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ActnList, OvcBase, ImgList,
  vtLister, vtOutliner, l3Tree_TLB, l3Interfaces, l3TreeInterfaces,
  l3Forms, l3InternalInterfaces, afwControl, afwInputControl,
  afwControlPrim, afwBaseControl;

type
  TOnInsertBlocks = procedure (aInsert: Boolean) of object;
  TddTuneBlocksDialog = class(Tl3Form, Il3NodeNotifyRecipient)
    ActionList1: TActionList;
    actUp: TAction;
    actDown: TAction;
    actDelete: TAction;
    BlockTree: TvtOutliner;
    UpButton: TButton;
    DownButton: TButton;
    DelButton: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure DelButtonClick(Sender: TObject);
    procedure UpButtonClick(Sender: TObject);
    procedure DownButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure BlockTreeCurrentChanged(Sender: TObject; aNewCurrent,
      aOldCurrent: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    function BlockTreeIsCommandProcessed(aSender: TObject;
      aOperation: Cardinal): Boolean;
    function BlockTreeGetItemImage(Sender: TObject; Index: Integer;
      var aImages: TCustomImageList): Integer;
    procedure BlockTreeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BlockTreeSelectChange(Sender: TObject; Index: Integer;
      var SelectedState: Integer);
    procedure BlockTreeGetItemFont(Sender: TObject; Index: Integer;
      const aFont: Il3Font);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure FormPaint(Sender: TObject);
  private
    FIndexOnIcon: Integer;
    FMyRoot: Il3Node;
    f_CountToMove: Integer;
    { Private declarations }
   f_SetData: Boolean;
   f_OnInsertBlocks: TOnInsertBlocks;
    f_MoveDirection: Cardinal;
   procedure CorrectBlockBorders(aNode: Il3SimpleNode; Up: Boolean);
   procedure ChangeVisibleSameLevel(aLevel: Integer; aVisible: Boolean);
   procedure ChangeVisibleSubTree(aNode: Il3Node);
   procedure DeleteOne(const aNode: Il3Node);
   procedure Notify(aOperation : Integer;  const aNode : Il3SimpleNode);
   {$IFDEF ShowBlockInfo}
   procedure ChangeNodeText(const aNode: Il3Node);
   {$ENDIF ShowBlockInfo}
  public
    property MyRoot: Il3Node read FMyRoot write FMyRoot;
    { Public declarations }
   property OnInsertBlocks: TOnInsertBlocks
    read f_OnInsertBlocks
    write f_OnInsertBlocks;
  end;

var
  ddTuneBlocksDialog: TddTuneBlocksDialog;

implementation

uses
  evAutoBlock,
  evInternalInterfaces,
  l3Types,  l3Nodes, l3Base,
  l3ControlsTypes,

  nevTools,

  OvcConst,

  vtStdRes
  ;

resourcestring
  SddTuneBlocksDlg_ConfirmSelected = 'Вы действительно хотите удалить выделенные узлы из структуры блоков?';
  SddTuneBlocksDlg_ConfirmOne = 'Вы действительно хотите удалить узел "%s" из структуры блоков?';


{$R *.dfm}

{$IFDEF ShowBlockInfo}
procedure TddTuneBlocksDialog.ChangeNodeText(const aNode: Il3Node);
var
 l_S, l_F: Integer;
 l_BI: IddBlockInfo;
 l_Level : Integer;
begin
 if Supports(aNode, IddBlockInfo, l_BI) then
 begin
  if l_BI.Finish <> nil then
   l_F:= l_BI.Finish.Position
  else
   l_F:= 0;
  if l_BI.Start <> nil then
   l_S:= l_BI.Start.Position
  else
   l_S:= 0;
  l_Level:= aNode.GetLevelFor(BlockTree.CTree.RootNode);
  aNode.Text:= PAnsiChar(Format('(Start:%d-Finish%d) Level %d', [l_S, l_F, l_Level]));
 end; // aNode.QueryInterface(IddBlockInfo, l_BI)
 BlockTree.Invalidate;
end;
{$ENDIF ShowBlockInfo}

procedure TddTuneBlocksDialog.DelButtonClick(Sender: TObject);
begin
 Il3CommandTarget(BlockTree).ProcessCommand(ccDel, true, 1);
end;

procedure TddTuneBlocksDialog.UpButtonClick(Sender: TObject);
begin
 Il3CommandTarget(BlockTree).ProcessCommand(ccMoveLeft, true, 1);
 BlockTreeCurrentChanged(BlockTree, BlockTree.Current, BlockTree.Current);
end;

procedure TddTuneBlocksDialog.DownButtonClick(Sender: TObject);
begin
 Il3CommandTarget(BlockTree).ProcessCommand(ccMoveRight, true, 1);
 BlockTreeCurrentChanged(BlockTree, BlockTree.Current, BlockTree.Current);
end;

procedure TddTuneBlocksDialog.CorrectBlockBorders(aNode: Il3SimpleNode; Up:
    Boolean);
var
 l_MovingNode, l_PrevNode: Il3Node;
 l_BI, l_MovingBlock: IddBlockInfo;
 l_Finish : InevBasePoint;
begin
 { Изменяем границы блоков в соответствии со структурой блоков }
 if Supports(aNode, Il3Node, l_MovingNode) then
 begin
  aNode.QueryInterface(IddBlockInfo, l_MovingBlock);
  if Up then
  begin
   l_PrevNode:= l_MovingNode.ParentNode;
   if Supports(l_PrevNode, IddBlockInfo, l_BI) then
   begin
    l_Finish := l_BI.CloneFinish;
    try
    (*if (l_BI.Finish <> nil) and (l_MovingBlock.Finish <> nil) and
      (l_BI.Finish.Position = l_MovingBlock.Finish.Position) and
      (l_BI.Start.Position < l_MovingBlock.Start.Position) then
     l_BI.Finish:= l_MovingBlock.Start;
    *)
     l_BI.Finish := l_MovingBlock.Start;
     l_MovingBlock.Finish := l_Finish;
    finally
     l_Finish := nil;
    end;
   end; // Supports(l_PrevNode, IddBlockInfo, l_BI)
  end // Up
  else
  begin
   l_PrevNode:= l_MovingNode.PrevNode;
   if Supports(l_PrevNode, IddBlockInfo, l_BI) then
    l_BI.Finish:= l_MovingBlock.Finish;
  end; // Down
  {$IFDEF ShowBlockInfo}
  ChangeNodeText(l_PrevNode);
  ChangeNodeText(l_MovingNode);
  {$ENDIF ShowBlockInfo}
 end; // aNode.QueryInterface(Il3Node, l_Node) = 0
end;

procedure TddTuneBlocksDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 if Assigned(f_OnInsertBlocks) then
  f_OnInsertBlocks(ModalResult = mrOk);
end;

procedure TddTuneBlocksDialog.BitBtn1Click(Sender: TObject);
begin
 ModalResult:= TButton(Sender).ModalResult;
 Close;
end;

procedure TddTuneBlocksDialog.BlockTreeCurrentChanged(Sender: TObject;
  aNewCurrent, aOldCurrent: Integer);
var
 l_Node: Il3Node;
 l_Level: Integer;
begin
 l_Node:= BlockTree.CTree.CNodes[aNewCurrent];
 l_Level:= l_Node.GetLevelFor(BlockTree.CTree.RootNode);
 actUp.Enabled:= l_Level > 1;
 actDown.Enabled := l_Node.GetNumInParent(True) > 0;
 actDelete.Enabled:= (l_Level > 0);
end;

procedure TddTuneBlocksDialog.DeleteOne(const aNode: Il3Node);
var
 l_Prev: Il3Node;
 l_BlockInfo, l_PrevBlockInfo: IddBlockInfo;
 l_Ok: Boolean;
begin
 { Удаляемый блок расширяет границы предыдущего }
 l_Prev:= BlockTree.CTree.GetPrev(aNode);
 if l_Prev <> nil then
 begin
  if Supports(aNode, IddBlockInfo, l_BlockInfo) and
     Supports(l_Prev, IddBlockInfo, l_PrevBlockInfo) then
  begin
   if (l_PrevBlockInfo.Finish <> nil) and (l_BlockInfo.Finish <> nil) then
    l_Ok:= (l_PrevBlockInfo.Finish.Position < l_BlockInfo.Finish.Position)
   else
   if (l_PrevBlockInfo.Finish <> nil) and (l_BlockInfo.Finish = nil) then
    l_Ok:= True
   else
    l_Ok:= False;
   if l_Ok then
    l_PrevBlockInfo.AdjustFinish(l_BlockInfo.Finish);
  end;
 end; // l_Prev
end;

procedure TddTuneBlocksDialog.Notify(aOperation : Integer;  const aNode :
    Il3SimpleNode);
var
 l_Node: Il3Node;
 l_BlockInfo : IddBlockInfo;
begin
 case aOperation of
  ntDelete     :
    {* - удаление элемента. Вызывается до уничтожения ссылки}
   if f_MoveDirection = 0 then
   begin
    // настоящие блоки удалять нельзя!
    //if Supports(aNode, IddBlockInfo, l_BlockInfo) then
    { Реагировать только в случае вызова удаления. Все остальные случаи пропускаем }
     if {(l_BlockInfo.RealType <> dd_cbBlock) and} Supports(aNode, Il3Node, l_Node) then
      DeleteOne(l_Node);
   end;
  ntDeleteDone :;
    {* - удаление элемента. Вызывается после уничтожения ссылки}
  ntMoveBegin  :
   {* - началось движение элемента. }
   begin
    { Видимо, тут нужно изменить границы перемещаемого блока }
    CorrectBlockBorders(aNode, f_MoveDirection = ccMoveLeft);
   end;
  ntMoveEnd    :
   begin
    Dec(f_CountToMove);
    if f_CountToMove = 0 then
     f_MoveDirection:= 0;
   end;
 end; // case aOperation
end;

procedure TddTuneBlocksDialog.FormCreate(Sender: TObject);
begin
 BlockTree.TreeStruct.Subscribe(Il3NodeNotifyRecipient(Self));
 BlockTree.EditOptions:= [eoItemHMoving, eoItemDelete];
 FIndexOnIcon:= -1;
end;

procedure TddTuneBlocksDialog.FormDestroy(Sender: TObject);
begin
 BlockTree.TreeStruct.Unsubscribe(Il3NodeNotifyRecipient(Self));
end;

function TddTuneBlocksDialog.BlockTreeIsCommandProcessed(aSender: TObject;
  aOperation: Cardinal): Boolean;
var
 l_BlockInfo : IddBlockInfo;
begin
 // вызов события происходит до выполнения операции
 Result:= True;
 case aOperation of
  ccDel:
   begin
    (*if aSender is TvtOuliner then
    begin
     TvtOutliner(aSender).CurrentCNode
    end;*)
   end;
  ccMoveLeft  ,
  ccMoveRight :
   begin
    f_MoveDirection:= aOperation;
    f_CountToMove:= BlockTree.CTree.SelectCount;
   end;
  ccMoveUp,
  ccMoveDown: Result:= False;
 end; // case
end;

function TddTuneBlocksDialog.BlockTreeGetItemImage(Sender: TObject;
  Index: Integer; var aImages: TCustomImageList): Integer;
var
 l_BI: IddBlockInfo;
begin
 Result:= -1;
 if Supports(BlockTree.TreeStruct.Nodes[Index], IddBlockInfo, l_BI) then
 begin
  aImages:= vtStdRes.vtStdResources.Images;
  if l_BI.Visible then
   Result:= 6
  else
   Result:= 5;
 end; // Supports  
end;

procedure TddTuneBlocksDialog.BlockTreeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 l_Part : Byte;
 l_BI: IddBlockInfo;
 l_Level: Integer;
 l_Node: Il3Node;
begin
 BlockTree.HitTest(Point(X, Y), FIndexOnIcon, l_Part);
 if l_Part = ihtIcon then
 begin
  l_Node:= BlockTree.CTree.CNodes[FIndexOnIcon];
  if (ssShift in Shift) or (ssCtrl in Shift) then
  begin
   if Supports(l_Node, IddBlockInfo, l_BI) then
   begin
    l_Level:= l_Node.GetLevelFor(BlockTree.CTree.RootNode);
    l_BI.Visible:= not l_BI.Visible;
   //  TShiftState = set of (ssShift, ssAlt, ssCtrl, ssLeft, ssRight, ssMiddle, ssDouble);
    if (ssShift in Shift) then
     ChangeVisibleSameLevel(l_Level, l_BI.Visible);
    if (ssCtrl in Shift) then
     ChangeVisibleSubTree(l_Node);
   end; // Supports 
  end
  else
  begin
   if BlockTree.CTree.SelectCount > 1 then
   begin
    l_Node:= BlockTree.CTree.GetNextSelect(nil);
    while l_Node <> nil do
    begin
     if Supports(l_Node, IddBlockInfo, l_BI) then
     begin
      if l_BI.RealType <> dd_cbBlock then
       l_BI.Visible:= not l_BI.Visible;
      l_Node:= BlockTree.CTree.GetNextSelect(l_Node);
     end; // Supports
    end; // while l_Node <> nil
   end
   else
   begin
    if Supports(l_Node, IddBlockInfo, l_BI) then
     if l_BI.RealType <> dd_cbBlock  then
      l_BI.Visible:= not l_BI.Visible;
   end;
  end;
  BlockTree.Invalidate;
 end // l_Part = ihtIcon
 else
  FIndexOnIcon:= -1;
end;

procedure TddTuneBlocksDialog.ChangeVisibleSameLevel(aLevel: Integer; aVisible:
    Boolean);

 procedure CVSL(const aNode: Il3Node);
 var
  l_BI: IddBlockInfo;
  l_Level: Integer;
 begin
  l_Level:= aNode.GetLevelFor(BlockTree.CTRee.RootNode);
  if l_Level = aLevel then
   if Supports(aNode, IddBlockInfo, l_BI) then
    l_BI.Visible:= aVisible;
 end;
 
begin
 BlockTree.CTRee.CRootNode.IterateF(l3L2NA(@CVSL))
end;

procedure TddTuneBlocksDialog.ChangeVisibleSubTree(aNode: Il3Node);
var
 l_BI: IddBlockInfo;
 l_Node: Il3Node;
begin
 { переключить видимость конкретного узла с предками }
 if Supports(aNode, IddBlockInfo, l_BI) then
  if l_BI.Visible then
  begin
   l_Node:= aNode.ParentNode;
   while l_Node <> nil do
   begin
    if Supports(l_Node, IddBlockInfo, l_BI) then
     l_BI.Visible:= True;
    l_Node:= l_Node.ParentNode;
   end; // l_Node <> nil
  end; // l_BI.Visible
end;

procedure TddTuneBlocksDialog.BlockTreeSelectChange(Sender: TObject;
  Index: Integer; var SelectedState: Integer);
begin
 if Index = fIndexOnIcon then
  SelectedState:= Ord(False);
 FIndexOnIcon:= -1;
end;

procedure TddTuneBlocksDialog.BlockTreeGetItemFont(Sender: TObject;
  Index: Integer; const aFont: Il3Font);
var
 l_BI: IddBlockInfo;
begin
 if Supports(BlockTree.TreeStruct.Nodes[Index], IddBlockInfo, l_BI) then
 begin
  if l_BI.RealType = dd_cbBlock then
   aFont.Style:= [fsBold];
  if not l_BI.Visible then
   aFont.ForeColor:= clGrayText;
 end; // Supports
end;

procedure TddTuneBlocksDialog.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
 // Отработать доступность команд

end;

procedure TddTuneBlocksDialog.FormPaint(Sender: TObject);
begin
 {$IfDef nsTest}
 BitBtn1.Click;
 // - чтоб в тестах всё работало АВТОМАТОМ
 {$EndIf nsTest}
end;

end.


