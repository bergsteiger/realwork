{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit FormFill;
interface
{$I dc.inc}
Uses
  SysUtils,Windows, Controls, Graphics, Classes, Forms, Messages,
  dcsystem,dcconsts,dcdreamlib;

Const cOther=clBtnFace;       //clsilver
      cFront =clBtnShadow;     //clgray
      cBack=clBtnHighlight;  //clwhite

type

 { This component can fill your form canvas with 17 different cute styles and
   will improve your application's look greately. Very fast. No tiled bitmaps.
 }
  TDCFormFill=class(TGraphicControl)
  private
    FRect:TRect;
    FFillType:Integer;
    TempDC,TempBmp,OldBmp:THandle;
    fOldWndProc : pointer;
    FOldPen,FOldBrush:THandle;
    FVersion : TDCVersion;
    Function  MagicConst:Integer;
    procedure RandomClone(ACloneSize,BegX:Integer);
    procedure SelectBrush(AColor:TColor);
    procedure SelectBrushPen(AColor:TColor);
    PROCEDURE paintitH(x,y: integer; front,back: TColor);
    procedure SelectPen(AColor:TColor);
    procedure UnselectPen;
    procedure UnselectBrush;
    procedure UnselectPenBrush;
    PROCEDURE paintit(x,y: integer; front,back: TColor);
    function  GetFillType:String;
    procedure SetFillType(Const V:String);
    procedure DoBeginFillType;
    procedure DoEndFillType;
    procedure HookWndProc;
    procedure UnHookWndProc;
    procedure NewWndProc(var Message : TMessage);
  protected
    procedure Paint;override;
    procedure SetParent(AParent : TWinControl); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy;  override;
  published
    property FillType:String Read GetFillType Write SetFillType;
    property DragCursor;
    property DragMode;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property Version : TDCVersion read FVersion write FVersion stored false;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

{--------------------------------------------------------------}

Type
  TFillTypeEvent=procedure(DCFormFill : TDCFormFill; Var CloneSize:Integer);

procedure FillBorders(DCFormFill:TDCFormFill);
procedure RegisterFillType(Const FormName:String; AProc:TFillTypeEvent);
procedure DoCloningFill(FromDC,ToDC: THandle; ASize:Integer;FRect:TRect);
procedure PElPasoSub(DCFormFill:TDCFormFill;Front,Back:TColor);

var
  FillTypeList:TStringList;

implementation

{--------------------------------------------------------------}

Const
  CSize = 30;
  cSize2 = cSize div 2;

{--------------------------------------------------------------}

procedure PElPasoSub(DCFormFill:TDCFormFill;Front,Back:TColor);
Const
     cMaxFront=3;
     cMaxBack=2;
     cFrontX:Array[1..cMaxFront] of Integer=(0,15,29);
     cBackX:Array[1..cMaxBack] of Integer=(1,16);
Var
  i:integer;

begin
  With DCFormFill do
  begin
    With Canvas.pen do
    begin
       Color:=Front;
       Mode:=pmCopy;
       Style:=psSolid;
       Width:=1;
    end;
    SelectPen(Front);
    For i:=1 to cMaxFront do
    begin
      Windows.MoveToEx(TempDC,cFrontX[i],0,nil);
      Windows.LineTo(TempDC,cFrontX[i],cSize);
    end;
    UnselectPen;

    SelectPen(back);
    For i:=1 to cMaxBack do
    begin
      Windows.MoveToEx(TempDC,cBackX[i],0,nil);
      Windows.LineTo(TempDC,cBackX[i],cSize);
    end;
    UnselectPen;
  end;
end;

{--------------------------------------------------------------}

procedure RegisterFillType(Const FormName:String; AProc:TFillTypeEvent);
begin
  If Assigned(AProc) then
    FillTypeList.AddObject(FormName,Addr(AProc));
end;

{--------------------------------------------------------------}

function TDCFormFill.GetFillType:String;
begin
  Result:=FillTypeList[FFillType];
end;

{--------------------------------------------------------------}

procedure TDCFormFill.SetFillType(Const V:String);
Var
  i:Integer;
begin
  If FillTypeList.Find(V,i) and (i<>FFillType) then
  begin
    FFillType:=i;
    Invalidate;
  end;
end;

{--------------------------------------------------------------}

PROCEDURE pPhiladelphia(DCFormFill : TDCFormFill; Var CloneSize:Integer);
BEGIN
  CloneSize:=1;
  With DCFormFill,DCFormFill.Canvas do
  begin
    FillBorders(DCFormFill);
    FillRect(Rect(5,ClientHeight-12,12,ClientHeight-5));
    FillRect(Rect(ClientWidth-12,5,ClientWidth-5,12));

    Pen.Color:=cfront;
    Brush.Color:=cfront;
    FillRect(Rect(12,ClientHeight-12,ClientWidth-5,ClientHeight-5));
    FillRect(Rect(ClientWidth-12,12,ClientWidth-5,ClientHeight-5));

    Brush.Color:=Cback;
    Pen.Color:=clblack;
    rectangle(5,5,clientwidth -12, clientheight -12);
  end;
END;

{--------------------------------------------------------------}

PROCEDURE pHanoi(DCFormFill : TDCFormFill; Var CloneSize:Integer);
Const
  cMaxPoints = 94;
  cPoints:Array[0..cMaxPoints] of array[0..1] of byte=(
  (0,0),   (9,0),   (1,10),  (2,11),  (3,12),  (4,13),  (4,14),  (4,15),  (4,16),  (4,17),
  (4,18),  (4,19),  (4,20),  (4,21),  (4,22),  (4,23),  (3,24),  (2,25),  (1,26),
  (0,27),  (0,28),  (0,29),  (0,30),  (0,27),  (1,2),   (2,3),   (3,4),   (4,5),
  (5,6),   (6,7),   (8,7),   (9,7),   (10,6),  (11,5),  (12,4),  (13,3),  (14,2),
  (15,1),  (16,0),  (17,0),  (18,0),  (18,1),  (17,2),  (16,4),  (15,5),  (15,6),
  (16,7),  (17,8),  (18,9),  (19,10), (19,11), (19,12), (18,13), (17,14),
  (16,15), (16,16), (15,18), (14,20), (13,21), (13,22), (13,23), (13,24),
  (13,25), (13,26), (14,27), (15,28), (16,28), (16,27), (16,26), (17,25),
  (18,24), (19,23), (19,22), (19,21), (19,20), (19,19), (19,18), (20,17),
  (20,16), (21,15), (22,14), (23,13), (23,12), (23,11), (23,10), (23,9),
  (23,8),  (23,7),  (23,6),  (24,5),  (25,4),  (26,3),  (27,2),  (28,1),  (29,0));

VAR
  z: integer;
BEGIN
  With DCFormFill do
  BEGIN
    For Z:=0 to CMaxPoints do
      paintit(cPoints[z][0],cPoints[z][1],cfront,cback);
    PElPasoSub(DCFormFill,cFront,cBack);
  END;
END;

{--------------------------------------------------------------}

PROCEDURE pMinsk(DCFormFill : TDCFormFill; Var CloneSize:Integer);
Var
  FOldObj:THandle;
BEGIN
  With DCFormFill,DCFormFill.Canvas do
  begin
    With Pen do
    begin
      style := psclear;
      FOldObj:=SelectObject(TempDC,Handle);
    end;
    SelectBrush(cother);
    Windows.rectangle(TempDC,0,0,7,32);
    UnselectBrush;

    SelectBrush(cBack);
    Windows.rectangle(TempDC,7,0,14,32);
    UnselectBrush;

    SelectBrush(cother);
    Windows.rectangle(TempDC,16,0,21,32);
    UnselectBrush;

    SelectBrush(cBack);
    Windows.rectangle(TempDC,21,0,30,32);
    UnselectBrush;

    SelectObject(TempDC,FOldObj);

    With Pen do
    begin
      style := pssolid;
    end;
    SelectPen(cFront);
    movetoEx(TempDC,14,0,nil);
    Windows.lineto(TempDC,14,30);
    movetoEx(TempDC,28,0,nil);
    Windows.lineto(TempDC,28,30);
    UnselectPen;
  end;
end;

{--------------------------------------------------------------}

procedure FillBorders(DCFormFill:TDCFormFill);
begin
  With DCFormFill,DCFormFill.Canvas do
  begin
    Brush.Color:=DCFormFill.Color;
    FillRect(Rect(0,0,ClientWidth,5));
    FillRect(Rect(0,ClientHeight-5,ClientWidth,ClientHeight));
    FillRect(Rect(0,5,5,ClientHeight-5));
    FillRect(Rect(ClientWidth-5,5,ClientWidth,ClientHeight-5));
  end;
end;
{--------------------------------------------------------------}

PROCEDURE pSmithsonian(DCFormFill : TDCFormFill; Var CloneSize:Integer);
VAR
  cw2,ch : integer;
BEGIN
  With DCFormFill,DCFormFill.Canvas do
  begin
    ch:=ClientHeight-9;
    cw2:=ClientWidth div 2;

    FillBorders(DCFormFill);

    Brush.Style:=bsClear;
    Pen.Color:=clblack;
    rectangle(5,5,clientwidth -5, clientheight -5);

    Brush.Style:=bsSolid;
    Brush.Color:=cFront;
    FillRect(Rect(6,6,ClientWidth-6,8));
    FillRect(Rect(6,ClientHeight-8,ClientWidth-6,ClientHeight-6));
    FillRect(Rect(6,8,8,ClientHeight-8));
    FillRect(Rect(ClientWidth-8,8,ClientWidth-6,ClientHeight-8));

    Brush.Color:=cback;
    Pen.Color:=clblack;
    rectangle(8,8,clientwidth -8, clientheight -8);

    Pen.Color:=cFront;
    moveto(cw2, 9);
    lineto(cw2, ch);

    Pen.Color:=cother;
    moveto(cw2 + 1, 9);
    lineto(cw2 + 1, ch);
    moveto(cw2 + 2, 9);
    lineto(cw2 + 2, ch);
    moveto(cw2 + 3, 9);
    lineto(cw2 + 3, ch);
    moveto(cw2 + 4, 9);
    lineto(cw2 + 4, ch);

    Pen.Color:=cback;
    moveto(cw2 + 5, 9);
    lineto(cw2 + 5, ch);

    Pen.Color:=cother;
    moveto(cw2 + 6, 9);
    lineto(cw2 + 6, ch);
    moveto(clientwidth - 10, 9);
    lineto(clientwidth - 10, ch);
    moveto(clientwidth - 15, 9);
    lineto(clientwidth - 15, ch);
    moveto(clientwidth - 16, 9);
    lineto(clientwidth - 18, ch);
    moveto(clientwidth - 20, 9);
    lineto(clientwidth - 20, ch);
    moveto(clientwidth - 25, 9);
    lineto(clientwidth - 25, ch);
    moveto(clientwidth - 30, 9);
    lineto(clientwidth - 30, ch);
    moveto(10, 9);
    lineto(10, ch);
    moveto(15, 9);
    lineto(15, ch);
    moveto(16, 9);
    lineto(18, ch);
    moveto(20, 9);
    lineto(20, ch);
    moveto(25, 9);
    lineto(25, ch);
    moveto(30, 9);
    lineto(30, ch);
    CloneSize:=0;
  end;
END;

{--------------------------------------------------------------}

procedure DoCloningFill(FromDC,ToDC: THandle; ASize:Integer;FRect:TRect);
Var
  x,y:Integer;
begin
  With FRect do
  begin
    x:=Left;
    y:=Top;
    While (y<Bottom) do
    begin
      BitBlt(ToDC,x,y,aSize,aSize,FromDC,0,0,SRCCopy);
      Inc(x,ASize);
      If (x>Right) then
      begin
        x:=0;
        inc(y,aSize);
      end;
    end;
  end;
end;

{--------------------------------------------------------------}

procedure TDCFormFill.SelectBrushPen(AColor:TColor);
begin
  SelectBrush(AColor);
  SelectPen(AColor);
end;

{--------------------------------------------------------------}

procedure TDCFormFill.UnselectPen;
begin
  SelectObject(TempDC,FOldPen);
end;

{--------------------------------------------------------------}

procedure TDCFormFill.UnselectBrush;
begin
  SelectObject(TempDC,FOldBrush);
end;

{--------------------------------------------------------------}

procedure TDCFormFill.UnselectPenBrush;
begin
  UnselectPen;
  UnselectBrush;
end;

{--------------------------------------------------------------}

procedure TDCFormFill.SelectPen(AColor:TColor);
begin
  With Canvas do
  begin
    pen.color := AColor;
    FOldPen:=SelectObject(TempDC,pen.Handle);
  end;
end;

{--------------------------------------------------------------}

procedure TDCFormFill.SelectBrush(AColor:TColor);
begin
  With Canvas.Brush do
  begin
    color := AColor;
    FOldBrush:=SelectObject(TempDC,Handle);
  end;
end;

{--------------------------------------------------------------}

PROCEDURE pPittsburg(DCFormFill : TDCFormFill; Var CloneSize:Integer);
BEGIN
  With DCFormFill, DCFormFill.Canvas do
  begin
    SelectPen(cBack);
    MoveToEx(TempDC,0,0,nil);
    Windows.lineto(TempDC,29,0);
    MoveToEx(TempDC,0,0,nil);
    Windows.lineto(TempDC,0,29);
    UnselectPen;

    SelectPen(cFront);
    Windows.lineto(TempDC,29,29);
    Windows.lineto(TempDC,29,0);
    UnselectPen;

    SelectBrushPen(cFront);
    Windows.ellipse(TempDC,4,4,6,6);
    Windows.ellipse(TempDC,26,26,28,28);
    Windows.ellipse(TempDC,4,26,6,28);
    Windows.ellipse(TempDC,26,4,28,6);
    UnselectPenBrush;

    SelectBrushPen(cBack);
    Windows.ellipse(TempDC,3,3,5,5);
    Windows.ellipse(TempDC,25,25,27,27);
    Windows.ellipse(TempDC,3,25,5,27);
    Windows.ellipse(TempDC,25,3,27,5);
    UnselectPenBrush;
  end;
END;

{--------------------------------------------------------------}

PROCEDURE pManhattan(DCFormFill : TDCFormFill; Var CloneSize:Integer);
VAR
  i:integer;
BEGIN
  With DCFormFill, DCFormFill.Canvas do
  BEGIN
    SelectPen(cBack);
    MoveToEx(TempDC,0,0,nil);
    Windows.lineto(TempDC,cSize,0);
    Windows.lineto(TempDC,cSize,cSize2);
    Windows.lineto(TempDC,0,cSize2);
    Windows.lineto(TempDC,0,0);
    movetoEx(TempDC,cSize2,cSize2,nil);
    Windows.lineto(TempDC,cSize2,cSize);
    UnselectPen;

    paintit(0,0,cfront,cback);
    DoCloningFill(TempDC,Handle,CloneSize,ClientRect);
    CloneSize:=1;
    For i:=1 to MagicConst div 3 do
    begin
      paintitH(random(ClientWidth),random(ClientHeight),cfront,cback);
      paintitH(random(ClientWidth),random(ClientHeight),cback,cfront);
    end;
  END;
END;

{--------------------------------------------------------------}

PROCEDURE pHonolulu(DCFormFill : TDCFormFill; Var CloneSize:Integer);
BEGIN
  With DCFormFill,DCFormFill.Canvas do
  begin
    SelectPen(cback);
    Windows.movetoEx(TempDC,0,cSize-1,nil);
    Windows.lineto(TempDC,cSize-1,0);
    UnselectPen;

    SelectPen(cFront);
    Windows.MoveToEx(TempDC,1,1,nil);
    Windows.lineto(TempDC,cSize,cSize);
    Windows.movetoEx(TempDC,1,cSize,nil);
    Windows.lineto(TempDC,cSize,1);
    UnselectPen;
  end;
END;

{--------------------------------------------------------------}

PROCEDURE TDCFormFill.paintit(x,y: integer; front,back: TColor);
BEGIN
   SelectPen(Front);
   MoveToEx(TempDC,x,y,nil);
   LineTo(TempDC,x+1,y+1);
   UnselectPen;

   SelectPen(Back);
   LineTo(TempDC,x+2,y+2);
   UnselectPen;
END;

{--------------------------------------------------------------}

PROCEDURE TDCFormFill.paintitH(x,y: integer; front,back: TColor);
BEGIN
   With Canvas do
   begin
     Pen.Color:=Front;
     MoveToEx(Handle,x,y,nil);
     Windows.LineTo(Handle,x+1,y+1);
     Pen.Color:=Back;
     Windows.LineTo(Handle,x+2,y+2);
   end;
END;

{--------------------------------------------------------------}

PROCEDURE pElPaso(DCFormFill : TDCFormFill; Var CloneSize:Integer);
VAR
  i: integer;
BEGIN
  With DCFormFill do
  BEGIN
    For i:=1 to 4 do
    begin
      paintit(random(cSize),random(cSize),cfront,cback);
      paintit(random(cSize),random(cSize),cback,cfront);
    end;
    PElPasoSub(DCFormFill,cFront,cBack);
  END;
END;

{--------------------------------------------------------------}

PROCEDURE DoSahara(DCFormFill : TDCFormFill; ATimes:Integer);
VAR
  i,x,y: integer;
BEGIN
  With DCFormFill do
  begin
    For i:=1 to ATimes do
    begin
      y := random(cSize);
      x := random(cSize);
      Paintit(x,y,cback,cFront);
    end;
  end;
END;

{--------------------------------------------------------------}

PROCEDURE pSahara(DCFormFill : TDCFormFill; Var CloneSize:Integer);
begin
  DoSahara(DCFormFill,150);
  With DCFormFill do
  begin
    DoCloningFill(TempDC,Canvas.Handle,CloneSize,ClientRect{Canvas.ClipRect} );
    CloneSize:=1;
    DCFormFill.RandomClone(15,0);
  end;
end;

{--------------------------------------------------------------}

PROCEDURE pHollywood(DCFormFill : TDCFormFill; Var CloneSize:Integer);
BEGIN
  With DCFormFill,DCFormFill.Canvas do
  begin
    SelectBrush(cOther);
    SelectPen(cBack);
    Windows.rectangle(TempDC,0,0,15,15);
    Windows.rectangle(TempDC,15,15,30,30);
    UnselectPenBrush;

    SelectBrush(cBack);
    SelectPen(cOther);
    Windows.rectangle(TempDC,0,15,15,30);
    Windows.rectangle(TempDC,15,0,30,15);
    UnselectPenBrush;
  end;
END;

{--------------------------------------------------------------}

procedure pHarvard(DCFormFill : TDCFormFill; Var CloneSize:Integer);
VAR
  w,x,y: integer;
BEGIN
  CloneSize:=1;
  With DCFormFill,DCFormFill.Canvas do
  begin
    Brush.Color:=Color;
    FillBorders(DCFormFill);
    FillRect(Rect(5,ClientHeight-8,8,ClientHeight-5));
    FillRect(Rect(ClientWidth-8,5,ClientWidth-5,8));

    Pen.Color:=cfront;
    Brush.Color:=cfront;
    FillRect(Rect(8,ClientHeight-8,ClientWidth-5,ClientHeight-5));
    FillRect(Rect(ClientWidth-8,8,ClientWidth-5,ClientHeight-5));

    Brush.Color:=cback;
    Pen.Color:=clblack;
    rectangle(5,5,clientwidth -8, clientheight -8);

    x := 8;
    y := 40;
    WHILE (y < clientheight -20) DO
    BEGIN
      Pen.Color:=clblue;
      MoveTo(x,y);
      LineTo(clientwidth - 10,y);
      MoveTo(clientwidth DIV 8,7);

      Pen.Color:=clred;
      LineTo(clientwidth DIV 8,clientheight -12);
      y := y + 20;
    END;

    w := clientheight DIV 4;
    x := clientwidth DIV 16;
    y := w DIV 2;
    Brush.Color:=cOther;

    WHILE (y < clientheight - (w DIV 2)) DO
    BEGIN
      Pen.Color:=cFront;
      ellipse(x-1,y-1,x + (x DIV 3),y + (x DIV 3));

      Pen.Color:=cBack;
      ellipse(x,y,x + (x DIV 3),y + (x DIV 3));
      y := y + w;
    END;
  end;
END;

{--------------------------------------------------------------}

procedure TDCFormFill.DoBeginFillType;
begin
  If TempDC<>0 then
    raise Exception.Create(SErrFillTypeStarted);
  With Canvas do
  begin
    TempDC := CreateCompatibleDC(Handle);
    TempBmp := CreateCompatibleBitmap(Handle, cSize, cSize);
    OldBmp:=SelectObject(TempDC,TempBmp);
    Brush.Color:=Self.Color;
    Windows.FillRect(TempDC,Rect(0,0,cSize,cSize),Brush.Handle);
  end;
end;

{--------------------------------------------------------------}

procedure TDCFormFill.DoEndFillType;
begin
  If TempDC<>0 then
  begin
    SelectObject(TempDC,OldBmp);
    DeleteObject(TempBmp);
    DeleteDc(TempDC);
    TempDC:=0;
  end;
end;

{--------------------------------------------------------------}

procedure TDCFormFill.Paint;
Var
  P:TFillTypeEvent;
  CloneSize:Integer;
begin
  FRect:=Canvas.ClipRect;
  P:=TFillTypeEvent(FillTypeList.Objects[FFillType]);
  CloneSize:=cSize;
  DoBeginFillType;

  P(Self, CloneSize);
  If CloneSize>0 then
  begin
    If CloneSize>1 then
      DoCloningFill(TempDC,Canvas.Handle,CloneSize,ClientRect);
  end;
  DoEndFillType;
end;

{--------------------------------------------------------------}

Constructor TDCFormFill.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csOpaque, csReplicatable];
  Align:=alClient;
  SendToBack;
end;

{--------------------------------------------------------------}

Destructor TDCFormFill.Destroy;
begin
  UnHookWndProc;
  inherited;
end;

{--------------------------------------------------------------}

procedure TDCFormFill.HookWndProc;
begin
  if Parent = nil then
    exit;
  fOldWndProc := pointer(GetWindowLong(Parent.Handle,GWL_WNDPROC));

  SetWindowLong(Parent.Handle, GWL_WNDPROC, Longint(

  {$IFDEF D6}
    Classes.MakeObjectInstance(NewWndProc)
  {$ELSE}
    MakeObjectInstance(NewWndProc)
  {$ENDIF}
  ));
end;

{------------------------------------------------------------------}

procedure TDCFormFill.UnHookWndProc;
begin
  if (Parent = nil) or (FOldWndProc=nil) then
    exit;

  SetWindowLong(Parent.Handle, GWL_WNDPROC, Longint(fOldWndProc));
  FOldWndProc:=nil;
end;

{------------------------------------------------------------------}

procedure TDCFormFill.SetParent(AParent : TWinControl);
Var
  i:Integer;
begin
  UnHookWndProc;
  inherited SetParent(AParent);
  If AParent<>nil then
    With AParent do
    begin
      For i:=0 to ControlCount-1 do
        If (Controls[i] is TDCFormFill) and (Controls[i]<>Self) then exit;
    end;
  HookWndProc;
end;

{--------------------------------------------------------------}

procedure TDCFormFill.NewWndProc(var Message : TMessage);
begin
  with Message do
    begin
      if (Msg = WM_ERASEBKGND) and Visible then
        begin
          Result := 1;
          exit;
        end;

      Result := CallWindowProc(fOldWndProc, Parent.Handle, Msg, WParam, LParam);
    end;
end;

{--------------------------------------------------------------}

procedure DrawHole(DCFormFill:TDCFormFill;front,back:TColor);
begin
  With DCFormFill do
  begin
    SelectBrushPen(Front);
    Windows.ellipse(TempDC,2,2,7,7);
    UnselectPenBrush;

    SelectPen(clSilver);
    SelectBrush(front);
    Windows.ellipse(TempDC,1,1,6,6);
    UnselectPenBrush;

    SelectPen(front);
    SelectBrush(back);
    Windows.ellipse(TempDC,0,0,5,5);
    UnselectPenBrush;

  end;
end;

{--------------------------------------------------------------}

Function TDCFormFill.MagicConst:Integer;
begin
  Result:=((ClientHeight*ClientWidth) div 225);
end;

{--------------------------------------------------------------}

procedure TDCFormFill.RandomClone(ACloneSize,BegX:Integer);
Var
  i,x,y:Integer;
begin
    For i:=0 to MagicConst do
    begin
      y:=Random(ClientHeight);
      x:=Random(ClientWidth);
      BitBlt(Canvas.Handle,x,y,aCloneSize,aCloneSize,TempDC,BegX,0,SRcCopy);
    end;
end;

{--------------------------------------------------------------}

PROCEDURE pHoles(DCFormFill : TDCFormFill; Var CloneSize:Integer);
BEGIN
  With DCFormFill,DCFormFill.Canvas do
  begin
    Brush.Color:=Color;
    FillRect(ClientRect);
    DrawHole(DCFormFill,cBack,cfront);
    CloneSize:=1;
    RandomClone(7,0);
  end;
END;

{--------------------------------------------------------------}

procedure pOshawa(DCFormFill : TDCFormFill; Var CloneSize:Integer);
begin
  pElPaso(DCFormFill,CloneSize);
  DoSahara(DCFormFill,150);
  With DCFormFill do
  begin
    DoCloningFill(TempDC,Canvas.Handle,CloneSize,ClientRect);
    CloneSize:=1;
    RandomClone(8,3);
  end;
end;

{--------------------------------------------------------------}

procedure pAdobe(DCFormFill : TDCFormFill; Var CloneSize:Integer);
Var
  A,TDc,TBmp,OBmp:THandle;
  ARect:TRect;
begin
  DoSahara(DCFormFill,100);
  With DCFormFill do
  begin
    DoCloningFill(TempDC,Canvas.Handle,CloneSize,Clientrect);
    CloneSize:=1;
    tDC := CreateCompatibleDC(Canvas.Handle);
    tBmp := CreateCompatibleBitmap(Canvas.Handle, 30, 30);
    OBmp:=SelectObject(TDC,TBmp);
    Canvas.Brush.Color:=Color;
    ARect:=Rect(0,0,7,7);
    Windows.FillRect(TDC,ARect,Canvas.Brush.Handle);
    A:=TempDC;
    TempDC:=TDc;
    DoSahara(DCFormFill,150);
    DrawHole(DCFormFill,cBack,cfront);
    RandomClone(7,0);
    TempDC:=A;
    SelectObject(TDC,OBmp);
    DeleteObject(TBmp);
    DeleteDc(TDC);
  end;
end;

{--------------------------------------------------------------}

PROCEDURE pAlcatraz(DCFormFill : TDCFormFill; Var CloneSize:Integer);
BEGIN
  ppittsburg(DCFormFill,CloneSize);
  With DCFormFill do
  begin
    SelectPen(cFront);
    SelectBrush(cFront);
    Windows.movetoEx(TempDC,6,0,nil);
    Windows.lineto(TempDC,6,30);
    UnselectPenBrush;

    SelectPen(cBack);
    movetoEx(TempDC,7,0,nil);
    Windows.lineto(TempDC,7,30);
    UnselectPen;

    SelectPen(cOther);
    movetoEx(TempDC,8,0,nil);
    Windows.lineto(TempDC,8,30);
    movetoEx(TempDC,9,0,nil);
    Windows.lineto(TempDC,9,30);
    movetoEx(TempDC,10,0,nil);
    Windows.lineto(TempDC,10,30);
    UnselectPen;

    SelectPen(cFront);
    movetoEx(TempDC,11,0,nil);
    Windows.lineto(TempDC,11,30);
    UnselectPen;

    SelectPen(cFront);
    movetoEx(TempDC,21,0,nil);
    Windows.lineto(TempDC,21,30);
    movetoEx(TempDC,23,0,nil);
    Windows.lineto(TempDC,23,30);
    movetoEx(TempDC,22,0,nil);
    Windows.lineto(TempDC,22,30);
    UnselectPen;
  end;
END;

{--------------------------------------------------------------}

procedure pLondon(DCFormFill : TDCFormFill; Var CloneSize:Integer);
VAR
  i,y,x: integer;
begin
  With DCFormFill, DCFormFill.Canvas do
  BEGIN
    DoSahara(DCFormFill,150);
    SelectPen(cBack);
    MoveToEx(TempDC,0,0,nil);
    Windows.lineto(TempDC,cSize,0);
    Windows.lineto(TempDC,cSize,cSize2);
    Windows.lineto(TempDC,0,cSize2);
    Windows.lineto(TempDC,0,0);
    movetoEx(TempDC,cSize2,cSize2,nil);
    Windows.lineto(TempDC,cSize2,cSize);
    UnselectPen;

    paintit(0,0,cfront,cback);
    DoCloningFill(TempDC,Handle,CloneSize,ClientRect);
    CloneSize:=1;

    For i:=0 to MagicConst*2 do
    begin
      y:=Random(ClientHeight);
      x:=Random(ClientWidth);
      BitBlt(Canvas.Handle,x,y, Min(10,(x div 15)*15-x),Min(10,(y div 15)*15-y),TempDC,2,2,SRcCopy);
    end;
  END;
end;

{--------------------------------------------------------------}

PROCEDURE pOrleans(DCFormFill : TDCFormFill; Var CloneSize:Integer);
Const
  cFrontPlus:Array[1..5] of byte=(0,1,14,15,28);
  cBackPlus:Array[1..3] of byte=(13,16,29);
VAR
  x,i: integer;
BEGIN
  pholes(DCFormFill,CloneSize);
  CloneSize:=0;
  x := 0;
  With DCFormFill,DCFormFill.Canvas do
  begin
    WHILE (x < ClientWidth) DO
    BEGIN
      Pen.Color:=cFront;
      For i:=1 to 5 do
      begin
        MoveTo(x+cFrontPlus[i],0);
        LineTo(x+cFrontPlus[i],ClientHeight);
      end;

      Pen.Color:=cBack;
      For i:=1 to 3 do
      begin
        MoveTo(x+cBackPlus[i],0);
        LineTo(x+cBackPlus[i],ClientHeight);
      end;
      Inc(x, 30);
    END;
  end;
END;

{--------------------------------------------------------------}
//BeginSkipConst
procedure _Register;
begin
  RegisterFillType('Adobe', pAdobe);
  RegisterFillType('Orleans', pOrleans);
  RegisterFillType('Alcatraz', pAlcatraz);
  RegisterFillType('Holes', pHoles);
  RegisterFillType('Oshawa', pOshawa);
  RegisterFillType('London', pLondon);
  RegisterFillType('Hollywood', pHollywood);
  RegisterFillType('Minsk', pMinsk);
  RegisterFillType('Hanoi', pHanoi);
  RegisterFillType('Pittsburg', pPittsburg);
  RegisterFillType('Manhattan', pManhattan);
  RegisterFillType('Honolulu', pHonolulu);
  RegisterFillType('ElPaso', pElPaso);
  RegisterFillType('Sahara', pSahara);
  RegisterFillType('Smithsonian', pSmithsonian);
  RegisterFillType('Philadelphia', pPhiladelphia);
  RegisterFillType('Harvard', pHarvard);
end;

{--------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
end;

{--------------------------------------------------------------}

initialization
  FillTypeList := CreateSortedStringList;
  RunRegister;
  randomize;

finalization
  FillTypeList.Free;
end.
