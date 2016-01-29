unit ExprEditControls;
{ $Id: ExprEditControls.pas,v 1.4 2014/02/14 15:33:40 lulin Exp $}

// $Log: ExprEditControls.pas,v $
// Revision 1.4  2014/02/14 15:33:40  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.3  2007/10/22 11:05:59  lulin
// - изменил имя базового класса.
//
// Revision 1.2  2007/08/21 12:43:23  lulin
// - избавляемся от предупреждений компилятора.
//
// Revision 1.1  2007/07/12 07:31:05  fireton
// - переезд в VT
//
// Revision 1.1  2007/06/22 15:06:38  fireton
// - первый коммит
//
interface
uses
 Types,
 Classes,
 Controls,
 Buttons,
 ImgList,


 l3Base,
 l3Interfaces,
 l3InternalInterfaces,

 vtLister;

type
 TExprViewRecord = record
  rPre: string;
  rPar: string;
  rSuf: string;
 end;

 TExprViewArray = array of TExprViewRecord;

 TExprViewArrayEnvelope = class(Tl3Base, Il3ViewStringList)
 private
  f_Array: TExprViewArray;
  f_ImgList: TImageList;
  function ItemImageIndexHandler(Sender : TObject; Index : Longint): Integer;
  function pm_GetCount: Longint;
  function pm_GetViewString(anIndex: Longint): Il3CString;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aArray: TExprViewArray);
    reintroduce;
  function Apply(const anIndex: Longint; const aParam: string): string;
  procedure BuildImgList;
  procedure AttachToLister(aLister: TvtIStrListLister);
  property ExprArray: TExprViewArray  read f_Array;
 end;

 TExprInsertEvent = procedure (aExpr: TExprViewRecord) of object;

 TExprButton = class(TSpeedButton)
 private
  f_ArrayEnvelope: TExprViewArrayEnvelope;
  f_OnExprInsert: TExprInsertEvent;
 protected
  procedure Click; override;
 public
  procedure SetArray(anArray: array of TExprViewRecord);
  destructor Destroy; override;
 published
  property OnExprInsert: TExprInsertEvent read f_OnExprInsert write f_OnExprInsert;
 end;

implementation

uses
 Graphics,

 ExprDraw,
 ExprMake,

 vtCtrls;

constructor TExprViewArrayEnvelope.Create(aArray: TExprViewArray);
begin
 inherited Create;
 f_Array := aArray;
 f_ImgList := nil;
end;

function TExprViewArrayEnvelope.Apply(const anIndex: Longint; const aParam: string): string;
begin
 with f_Array[anIndex] do
 begin
  if aParam <> '' then
   Result := rPre + aParam + rSuf
  else
   Result := rPre + rPar + rSuf; 
 end;
end;

procedure TExprViewArrayEnvelope.AttachToLister(aLister: TvtIStrListLister);
begin
 if not Assigned(f_ImgList) then
  BuildImgList;
 aLister.Items := Self;
 aLister.Images := f_ImgList;
 aLister.OnGetItemImageIndex := ItemImageIndexHandler;
end;

procedure TExprViewArrayEnvelope.BuildImgList;
var
 l_Bmps: array of TBitmap;
 I: Integer;
 l_MaxWidth: Integer;
 l_MaxHeight: Integer;
 l_Expr: Tl3Expr;
 l_MaxChanged: Boolean;

 procedure ResizeToMax(var aBmp: TBitmap; AlignToRight: Boolean = True);
 var
  l_Bmp: TBitmap;
  l_XPos: Integer;
  l_YPos: Integer;
 begin
  l_Bmp := TBitmap.Create;
  with l_Bmp do
  begin
   Width  := l_MaxWidth;
   Height := l_MaxHeight;
   Canvas.Brush.Style:=bsSolid;
   Canvas.Brush.Color:= clBtnFace;
   Canvas.FillRect(Rect(0,0,Width,Height));
  end;
  l_XPos := l_MaxWidth - aBmp.Width;
  if not AlignToRight then
   l_XPos := l_XPos div 2;
  l_YPos := (l_MaxHeight - aBmp.Height) div 2;

  l_Bmp.Canvas.CopyRect(Rect(l_XPos, l_YPos, l_XPos + aBmp.Width, l_YPos + aBmp.Height),
      aBmp.Canvas, Rect(0, 0, aBmp.Width, aBmp.Height));
  l3Free(aBmp);
  aBmp := l_Bmp;    
 end;

 procedure AdjustAll(AlignToRight: Boolean = True);
 var
  I: Integer;
 begin
  for I := Low(l_Bmps) to High(l_Bmps) do
   if Assigned(l_Bmps[I]) then
   begin
    if (l_Bmps[I].Width < l_MaxWidth) or (l_Bmps[I].Height < l_MaxHeight) then
     ResizeToMax(l_Bmps[I], AlignToRight);
   end;
 end;

begin
 if f_ImgList <> nil then
  l3Free(f_ImgList);
 f_ImgList := TImageList.Create(nil);
 SetLength(l_Bmps, High(f_Array)+1);
 try
  l_MaxWidth := 0;
  l_MaxHeight := 0;
  for I := Low(l_Bmps) to High(l_Bmps) do
   l_Bmps[I] := nil;
  for I := Low(f_Array) to High(f_Array) do
  begin
   l_MaxChanged := False;
   with f_Array[I] do
    l_Expr := SafeBuildExpr(rPre + rPar + rSuf);
   try
    l_Bmps[I] := TBitmap.Create;
    with l_Bmps[I] do
    begin
     Width := 2000;
     Height := 1000;
     Canvas.Brush.Style := bsSolid;
     Canvas.Brush.Color := clBtnFace;
     Canvas.FillRect(Rect(0, 0, Width, Height));
    end;
    l_Expr.Canvas := l_Bmps[I].Canvas;
    l_Expr.Font.Size := 12;
    l_Expr.Draw(0, 0, ehLeft, evTop);
    with l_Bmps[I] do
    begin
     Width  := l_Expr.Width;
     Height := l_Expr.Height;
    end;
    if l_Bmps[I].Width > l_MaxWidth then
    begin
     l_MaxChanged := True;
     l_MaxWidth := l_Bmps[I].Width;
    end;
    if l_Bmps[I].Height > l_MaxHeight then
    begin
     l_MaxChanged := True;
     l_MaxHeight := l_Bmps[I].Height;
    end;
    if l_MaxChanged then
     AdjustAll
    else
     ResizeToMax(l_Bmps[I]);
   finally
    l3Free(l_Expr);
   end;
  end;
  f_ImgList.Width  := l_MaxWidth;
  f_ImgList.Height := l_MaxHeight;
  f_ImgList.Masked := False;
  for I := Low(l_Bmps) to High(l_Bmps) do
   f_ImgList.Add(l_Bmps[I], nil);
 finally
  for I := Low(l_Bmps) to High(l_Bmps) do
   if Assigned(l_Bmps[I]) then
    l3Free(l_Bmps[I]);
  l_Bmps := nil;
 end;
end;

procedure TExprViewArrayEnvelope.Cleanup;
begin
 if Assigned(f_ImgList) then
  l3Free(f_ImgList);
 f_Array := nil;
 inherited;
end;

function TExprViewArrayEnvelope.ItemImageIndexHandler(Sender : TObject; Index : Longint): Integer;
begin
 Result := Index;
end;

function TExprViewArrayEnvelope.pm_GetCount: Longint;
begin
 Result := High(f_Array) + 1;
end;

function TExprViewArrayEnvelope.pm_GetViewString(anIndex: Longint): Il3CString;
begin
 with f_Array[anIndex] do
  Result := l3CStr(rPre + rPar + rSuf);
end;

destructor TExprButton.Destroy;
begin
 if Assigned(f_ArrayEnvelope) then
  l3Free(f_ArrayEnvelope);
 inherited;
end;

procedure TExprButton.Click;
var
 l_PopupList: TvtPopupList;
 l_Res: Integer;
begin
 inherited;
 if Assigned(f_ArrayEnvelope) then
 begin
  l_PopupList := TvtPopupList.Create(Self, TvtIStrListLister);
  try
   f_ArrayEnvelope.AttachToLister(l_PopupList.Lister as TvtIStrListLister);
   l_Res := l_PopupList.Execute;
   if (l_Res >= 0) and Assigned(f_OnExprInsert) then
    f_OnExprInsert(f_ArrayEnvelope.ExprArray[l_Res]);
  finally
   l3Free(l_PopupList);
  end;
 end;
end;

procedure TExprButton.SetArray(anArray: array of TExprViewRecord);
var
 l_Array: TExprViewArray;
 I: Integer;
begin
 if Assigned(f_ArrayEnvelope) then
  l3Free(f_ArrayEnvelope);
 SetLength(l_Array, High(anArray)+1);
 for I := 0 to High(anArray) do
  l_Array[I] := anArray[I];
 f_ArrayEnvelope := TExprViewArrayEnvelope.Create(l_Array); 
end;

end.
