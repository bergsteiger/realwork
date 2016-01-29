unit fr_SubCombo;

// $Id: fr_SubCombo.pas,v 1.24 2014/05/05 05:31:02 dinishev Exp $

// $Log: fr_SubCombo.pas,v $
// Revision 1.24  2014/05/05 05:31:02  dinishev
// Bug fix: не собиралось.
//
// Revision 1.23  2014/04/30 13:11:38  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.22  2013/10/21 15:42:18  lulin
// - потихоньку избавл€емс€ от использовани€ идентификаторов типов тегов.
//
// Revision 1.21  2013/10/21 10:30:04  lulin
// - потихоньку избавл€емс€ от использовани€ идентификаторов типов тегов.
//
// Revision 1.20  2009/06/02 17:23:15  lulin
// - удалены ненужные интерфейсы и переопределени€ типов.
//
// Revision 1.19  2009/04/07 16:40:54  lulin
// [$140837386]. є13. Ќе собиралс€ јрхивариус.
//
// Revision 1.18  2009/03/04 14:17:45  lulin
// - <K>: 137470629. √енерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.17  2007/12/26 00:16:33  lulin
// - модуль l3Tree_TLB полностью перенесен на модель.
//
// Revision 1.16  2007/12/05 13:51:25  lulin
// - bug fix: не собиралс€ Ёверест.
//
// Revision 1.14.2.1  2007/03/27 07:57:59  dinishev
// Bug fix: не собиралс€ Everest в ветке
//
// Revision 1.14  2005/05/27 14:44:25  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.13  2005/04/26 08:43:30  lulin
// - bug fix: не компилировалось.
//
// Revision 1.12  2005/03/24 12:40:31  lulin
// - remove method: Ik2TagBox.Tag.
// - new method: Ik2TagBox.Target.
//
// Revision 1.11  2004/12/23 11:16:13  lulin
// - rename prop: TvtCustomOutliner.TreeSource -> TreeStruct.
//
// Revision 1.10  2004/05/26 17:01:52  law
// - new behavior: TvtCustomOutliner теперь знает только про интерфейсы Il3SimpleTree и Il3Tree, а не про объект Tl3Tree.
//
// Revision 1.9  2004/05/05 14:59:07  law
// - изменени€ в св€зи с переименованием модул€.
//
// Revision 1.8  2004/03/15 14:22:44  law
// - change: переделки в св€зи с изменением библиотек компонентов.
//
// Revision 1.7  2002/04/06 11:33:47  law
// - Delphi 6.0.
//
// Revision 1.6.2.1  2002/04/06 11:25:13  law
// - cleanup & bugfix.
//
// Revision 1.6  2001/05/24 14:29:51  law
// - new behavior: подстраиваемс€ под изменени€ ¬ована, относительно PopupWindow.
//
// Revision 1.5  2001/05/23 14:00:45  law
// - new behavior: подстраиваемс€ под изменени€ ¬ована, относительно PopupWindow.
//
// Revision 1.4  2001/05/07 08:54:36  law
// - new behavior: Tl3Tree ->Il3RootNode.
// - cleanup: убраны ненужные ссылки на RXSpin.
//
// Revision 1.3  2000/12/15 16:22:06  law
// - вставлены директивы Log.
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, ImgList, Forms, Dialogs,
  OvcBase, l3Types, l3Base,  vtLister, vtOutliner, TB97Ctls, evButton,
  StdCtrls, vtSpin, tb97GraphicControl, afwControl, afwInputControl,
  afwControlPrim, afwBaseControl;

type
  TfrSubCombo = class(TFrame)
    seSubID: TvtSpinEdit;
    btSubID: TevButton;
    otlSub: TvtOutliner;
    procedure FrameResize(Sender: TObject);
    procedure btSubIDClick(Sender: TObject);
    function otlSubGetItemImage(Sender: TObject;
      Index: Integer; var aImages : TCustomImageList): Integer;
    procedure otlSubActionElement(Sender: TObject; Index: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  l3Tree_TLB,
  l3Variant,

  k2Interfaces,
  k2Tags,

  evInternalInterfaces,

  vtCtrls,

  Document_Const,
  Block_Const,

  nevTools
  ;

{$R *.DFM}

procedure TfrSubCombo.FrameResize(Sender: TObject);
begin
 with seSubID do
  BoundsRect := Bounds(0, 0, Self.Width - btSubID.Width, Self.Height);
 with btSubID do 
  BoundsRect := Bounds(seSubID.Width, 0, Width, Self.Height);
end;

procedure TfrSubCombo.btSubIDClick(Sender: TObject);
var
 l_PopupList : TVPopupWindow;
 l_Form      : TCustomForm;
begin
 l_PopupList := TVPopupWindow.Create(TComponent(Sender), otlSub);
 try
  with l_PopupList do begin
   AdjustCorner := acBottomRight;
   Width := Self.Width;
   l_Form := GetParentForm(Self);
   if (l_Form = nil) then
    Height := 100
   else
    Height := l_Form.ClientToScreen(Point(0, l_Form.ClientRect.Bottom)).Y -
              Self.ClientToScreen(Point(0, Self.Height)).Y - 20;
   Execute;
   with otlSub do begin
    Visible := false;
    Align := alNone;
    Parent := Self;
   end;//with otlSub
  end;
 finally
  l3Free(l_PopupList);
 end;//try..finally
end;

function TfrSubCombo.otlSubGetItemImage(Sender: TObject;
  Index: Integer; var aImages : TCustomImageList): Integer;
var
 N : Il3Node;
 l_TagWrap : Il3TagRef;
begin
 Result := -1;
 if Supports(otlSub.TreeStruct.Nodes[Index], Il3Node, N) then
  if l3IOk(N.QueryInterface(Il3TagRef, l_TagWrap)) then
   try
    with l_TagWrap.AsObject do
    begin
     if IsKindOf(k2_typDocument) then
      Result := 1
     else
     if IsKindOf(k2_typBlock) then
      Result := 9
     else
      Result := 8;
    end;{with l_TagWrap}
   finally
    l_TagWrap := nil;
   end;{try..finally}
end;

procedure TfrSubCombo.otlSubActionElement(Sender: TObject; Index: Integer);
var
 N : Il3Node;
 l_Sub : IevSub;
begin
 if Supports(otlSub.TreeStruct.Nodes[Index], Il3Node, N) then
  if (N <> nil) AND l3IOk(N.QueryInterface(IevSub, l_Sub)) then
   try
    TVPopupWindow(otlSub.Parent).ExecResult := l_Sub.ID;
    seSubID.AsInteger := l_Sub.ID;
    seSubID.Modified := true;
   finally
    l_Sub := nil;
   end;{try..finally}
end;

end.
