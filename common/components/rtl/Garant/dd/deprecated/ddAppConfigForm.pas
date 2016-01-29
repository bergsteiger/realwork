//..........................................................................................................................................................................................................................................................
{ Форма для редактирования настроек приложения }
unit ddAppConfigForm;
{ $Id: ddAppConfigForm.pas,v 1.1 2015/02/19 18:03:47 lulin Exp $ }

// $Log: ddAppConfigForm.pas,v $
// Revision 1.1  2015/02/19 18:03:47  lulin
// - прячем код, который похоже уже протух.
//
// Revision 1.31  2013/05/14 09:46:33  lulin
// - разборки с упавшими тестами.
//
// Revision 1.30  2007/04/13 07:53:44  lulin
// - bug fix: неправильно позиционировались на предыдущий узел.
//
// Revision 1.29  2005/01/14 09:20:56  narry
// - update: рефакторинг в преддверии добавления нового класса
//
// Revision 1.28  2004/06/03 12:27:10  narry
// - update: новая идеология окна конфигурации
//
// Revision 1.27  2004/05/31 18:14:46  demon
// - warning fix
//
// Revision 1.26  2004/05/07 12:25:23  narry
// - bug fix: неправильное вычисление размера при AutoSize
//
// Revision 1.25  2004/05/07 10:35:09  narry
// - bug fix: неправильное вычисление размера при AutoSize
//
// Revision 1.24  2004/05/07 10:14:38  narry
// - bug fix: неправильное вычисление размера при AutoSize
//
// Revision 1.22.2.3  2004/04/21 15:43:54  narry
// - update
// - bug fix: не "выключались" дополнительные элементы строковых элементов
//
// Revision 1.22.2.1  2004/03/16 16:58:41  narry
// - update: переделка с TPanel на TFrame
//
// Revision 1.22  2004/03/11 14:15:29  narry
// - bug fix: AV при закрытии окна конфигурации по кнопке ОК
// - bug fix: неправильная длина элемента IntegerConfigItem
//
// Revision 1.21  2004/03/10 15:33:15  narry
// - update: замена содержимым ветки
//
// Revision 1.18.2.8  2004/03/09 16:57:00  narry
// - update: продолжение рефакторинга, на 90% восстановлена былая функциональность
//
// Revision 1.18.2.7  2004/03/05 15:04:26  narry
// - update: восстановлен TRadioGroup, снято ограничение с размера формы в режиме AutoSize
//
// Revision 1.18.2.6  2004/03/04 17:53:52  narry
// - update: продолжение рефакторинга, на 80% восстановлена былая функциональность
//
// Revision 1.18.2.5  2004/03/03 17:18:44  narry
// - update: продолжение рефакторинга
//
// Revision 1.18  2004/02/24 13:35:43  narry
// - new: использование PasswordChar для ввода "секретных" строк
//
// Revision 1.17  2004/02/24 12:53:01  narry
// - update: выравнивание элементов с меткой слева
//
// Revision 1.16  2004/02/20 16:48:53  narry
// - update: минимальная ширина элемента dd_citFont
//
// Revision 1.15  2004/02/20 16:42:26  narry
// - add: новый тип элемента dd_citFont
//
// Revision 1.14  2004/02/19 17:43:16  narry
// - add: подгонка ширины элемента редактирования чисел при задании максимального возможного значения
//
// Revision 1.13  2004/02/19 13:11:28  narry
// - add: расположение метки слева от элемента (для IntegerItem)
//
// Revision 1.12  2004/02/18 13:24:32  narry
// - update: учитывание ширины текста при вычислении ширины окна в режиме AutoSize
//
// Revision 1.11  2004/02/17 15:08:11  narry
// - update: первое приближение свойства AutoSize
//
// Revision 1.10  2004/02/16 11:11:45  narry
// - new: новые типы элементов - цвет и имя шрифта
// - cleanup
//
// Revision 1.9  2004/02/13 14:43:43  narry
// - update
//
// Revision 1.8  2004/02/13 12:48:18  narry
// - bug fix: неправильно отрабатывалось изменение состояния в цепочке связанных элементов
//
// Revision 1.7  2004/02/06 17:11:47  narry
// - bug fix: не сохранялились и не загружались значения для типа dd_citRadio
// - add: новый тип элемента dd_citRadioGroup
//
// Revision 1.6  2004/02/06 16:38:32  fireton
// - bugfix: RadioButtons stuff
//
// Revision 1.5  2004/02/04 12:48:50  fireton
// - bug fix: AV при присвоении свойств "мертвой" ссылке на объект
//
// Revision 1.4  2004/02/04 12:23:00  narry
// - update: очередной шаг к совершенству
//
// Revision 1.3  2004/01/22 17:58:20  narry
// - update: начало реализации редактирования элементов списка
//
// Revision 1.2  2003/12/01 15:20:34  narry
// - cleanup
// - bug fix: Integer overflow при формировании номера блока глубокой вложенности
// -change: переименование пункта "Произвольно" в "Больше пяти уровней" и перенос его в конец списка
//
// Revision 1.1  2003/11/19 17:55:19  narry
// - new: хранение и отображение настроек приложения
//

{$Include ddDefine.inc}

{.$DEFINE RxLibrary}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, ddAppConfigTypes;

type
  TddAppConfigForm = class(TForm)
    ApplyButton: TButton;
    Bevel1: TBevel;
    ButtonsPanel: TPanel;
    CancelButton: TButton;
    CaptionPanel: TPanel;
    ComponentsPanel: TPanel;
    ConfigTree: TTreeView;
    HelpButton: TButton;
    OkButton: TButton;
    TreePanel: TPanel;
    WorkPanel: TPanel;
    procedure ApplyButtonClick(Sender: TObject);
    procedure ConfigTreeChange(Sender: TObject; Node: TTreeNode);
    procedure ConfigTreeChanging(Sender: TObject; Node: TTreeNode; var
            AllowChange: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FAdjustFormSize: Boolean;
    FDrawLabelTop: Boolean;
    FMinHeight: Integer;
    FMinWidth: Integer;
    f_Construction: Boolean;
    procedure CreateComponents;
    procedure CreateTree(const aTree: TddBaseConfigNode);
    procedure DestroyComponents;
    function GetItemIndex: Integer;
    procedure ReadValues(const aRead: Boolean = True);
    procedure RecalcFormSize;
  public
    function Execute(const aTree: TddBaseConfigNode; aItemIndex: Integer):
            Boolean;
    procedure UpdateControlStatus(aControl: TWinControl);
    property AdjustFormSize: Boolean read FAdjustFormSize write FAdjustFormSize;
    property DrawLabelTop: Boolean read FDrawLabelTop write FDrawLabelTop;
    property ItemIndex: Integer read GetItemIndex;
  end;
  
implementation

{$R *.dfm}


Uses
//{$IFDEF RxLibrary}
// ToolEdit, RxSpin, RxCombos,
//{$ENDIF}
 Math, ddAppConfigConst;

{
******************************* TddAppConfigForm *******************************
}
procedure TddAppConfigForm.ApplyButtonClick(Sender: TObject);
begin
  ReadValues;
  ApplyButton.Enabled:= False;
end;

procedure TddAppConfigForm.ConfigTreeChange(Sender: TObject; Node: TTreeNode);
begin
  { перерисовать панель свойств. Для начала - заголовок }
  CaptionPanel.Caption:= Node.Text;
  ComponentsPanel.Controls[Node.AbsoluteIndex].Visible:= True;
  ComponentsPanel.Controls[Node.AbsoluteIndex].Refresh;
end;

procedure TddAppConfigForm.ConfigTreeChanging(Sender: TObject; Node: TTreeNode;
        var AllowChange: Boolean);
begin
  if ConfigTree.Selected <> nil then
  begin
   { Считываем значения из текущей закладки }
   ComponentsPanel.Controls[ConfigTree.Selected.AbsoluteIndex].Visible:= False;
  end; // ConfigTree.Selected <> nil
end;

procedure TddAppConfigForm.CreateComponents;
var
  i: Integer;
  l_Frame: TFrame;
  l_Node: TTreeNode;
  l_CN: TddAppConfigNode;
begin
  f_Construction:= True;
  if AdjustFormSize then
   RecalcFormSize;
  for i:= 0 to Pred(ConfigTree.Items.Count) do
  begin
   l_Node:= ConfigTree.Items.Item[i];
   l_CN:= TddAppConfigNode(l_Node.Data);
   l_Frame:= l_CN.CreateFrame(ComponentsPanel, i);
   if l_Frame.Parent = nil then
    ComponentsPanel.InsertControl(l_Frame);
   l_Frame.Visible:= False;
  end; // for i
  f_Construction:= False;
  ReadValues(False);
end;

procedure TddAppConfigForm.CreateTree(const aTree: TddBaseConfigNode);
  
   procedure ConvertNode(const aNode: TddBaseConfigNode; aTreeNode: TTreeNode);
   var
    i: Integer;
   begin
    if aTreeNode = nil then
     aTreeNode:= ConfigTree.Items.AddObject(aTreeNode, aNode.Caption, aNode)
    else
     aTreeNode:= ConfigTree.Items.AddChildObject(aTreeNode, aNode.Caption, aNode);
    for i:= 0 to Pred(aNode.ChildrenCount) do
     ConvertNode(aNode.Childrens[i], aTreeNode);
   end;
  var
   j: Integer;
  
begin
  ConfigTree.Items.Clear;
   for j:= 0 to Pred(aTree.ChildrenCount) do
    ConvertNode(aTree.Childrens[j], nil);
end;

procedure TddAppConfigForm.DestroyComponents;
var
  i: Integer;
begin
  ComponentsPanel.DestroyComponents;
  // Нужно очистить ссылки на контролы
  for i:= 0 to Pred(ConfigTree.Items.Count) do
   TddAppConfigNode(ConfigTree.Items[i].Data).ClearControls;
end;

function TddAppConfigForm.Execute(const aTree: TddBaseConfigNode; aItemIndex:
        Integer): Boolean;
begin
  CreateTree(aTree);
  CreateComponents;
  try
   if (aItemIndex = -1) or (aItemIndex >= ConfigTree.Items.Count) then
    ConfigTree.Selected:= ConfigTree.Items.GetFirstNode
   else
    ConfigTree.Selected:= ConfigTree.Items[aItemIndex];
   Result:= ShowModal = mrOk;
   if Result then
    ReadValues;
  finally
   DestroyComponents;
  end;
end;

procedure TddAppConfigForm.FormCreate(Sender: TObject);
begin
  FAdjustFormSize:= False;
  fDrawLabelTop:= True;
  FMinWidth:= 4*HelpButton.Width + 5*12;
  FMinHeight:= ClientHeight-ComponentsPanel.Height;
end;

procedure TddAppConfigForm.FormResize(Sender: TObject);
begin
  ConfigTree.Height:= TreePanel.ClientHeight - 4;
end;

function TddAppConfigForm.GetItemIndex: Integer;
begin
  if ConfigTree.Selected <> nil then
   Result := ConfigTree.Selected.AbsoluteIndex
  else
   Result:= -1;
end;

procedure TddAppConfigForm.ReadValues(const aRead: Boolean = True);
var
  l_CN: TddAppConfigNode;
  I: Integer;
begin
  { Перебираем все элементы на панелях и возвращаем или устанавливаем значения }
  for i:= 0 to Pred(ComponentsPanel.ControlCount) do
  begin
   { Перебираем панели }
   if ComponentsPanel.Controls[i] is TFrame then
   begin
    l_CN:= TddAppConfigNode(ConfigTree.Items.Item[ComponentsPanel.Controls[i].Tag].Data);
    if aRead then
     l_CN.GetControlValues
    else
     l_CN.SetControlValues(False)
   end; // ComponentsPanel.Controls[i] is TPanel
  end; // for i
end;

procedure TddAppConfigForm.RecalcFormSize;
var
  i: Integer;
  l_Node: TTreeNode;
  l_CN: TddBaseConfigNode;
  l_MaxHeight, l_CurHeight: Integer;
  l_MaxWidth: Integer;
  l_Height, l_Width: Integer;
begin
  l_MaxHeight:= Low(l_MaxHeight);
  l_MaxWidth:= Low(l_MaxWidth);
  // Вычисление максимальных ширин и высот панелей
  for i:= 0 to Pred(ConfigTree.Items.Count) do
  begin
   l_Node:= ConfigTree.Items.Item[i];
   l_CN:= TddBaseConfigNode(l_Node.Data);
   l_CN.FrameSize(Self, l_Height, l_Width);
   l_MaxHeight:= Max(l_MaxHeight, l_Height);
   l_MaxWidth:= Max(l_MaxWidth, l_Width);
  end; // for i
  // Окончательный пересчет
  l_Height:= FMinHeight+l_MaxHeight;
  l_Width:= Max(FMinWidth, l_MaxWidth+WorkPanel.Left+ComponentsPanel.Left+2*WorkPanel.BorderWidth);
  l_CurHeight:= MulDiv(l_Width, 10, 14);
  if l_CurHeight < l_Height then
   l_Width:= MulDiv(l_Height, 14, 10)
  else
   l_Height:= l_CurHeight;
  ClientHeight:= l_Height;
  ClientWidth:= l_Width;
end;

procedure TddAppConfigForm.UpdateControlStatus(aControl: TWinControl);
var
  i, j: Integer;
  l_Control, l_SubControl: TControl;
  l_Node: TddAppConfigNode;
  l_Master, l_Slave: TddBaseConfigItem;
  l_Checked: Boolean;
begin
  { Изменение доступности элементов в зависимости от состояния ведущего компонента }
  l_Node:= TddAppConfigNode(ConfigTree.Items.Item[aControl.Tag].Data);
  for i:= 0 to Pred(aControl.ControlCount) do
  begin
   l_Control:= aControl.Controls[i];
   if (l_Control is TButtonControl) then
   begin
    if l_Control is TCheckBox then
     l_Checked:= (l_Control as TCheckBox).Checked
    else
    if l_Control is TRadioButton then
     l_Checked:= (l_Control as TRadioButton).Checked;
    l_Checked:= l_Checked and l_Control.Enabled;
    l_Master:= l_Node.ItemByIndex[l_Control.Tag];
    for j:= 0 to Pred(aControl.ControlCount) do
    begin
     l_SubControl:= aControl.Controls[j];
     if l_SubControl <> l_Control then
     begin
      l_Slave:= l_Node.ItemByIndex[l_SubControl.Tag];
      if l_Slave.MasterItem = l_Master then
       l_SubControl.Enabled:= l_Checked;
     end; // l_SubControl <> l_Control
    end; // for j
   end; // l_Control is TButtonControl
  end; // for i
end;

end.











