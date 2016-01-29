unit vtGradientWaitbar;

{ $Id: vtGradientWaitbar.pas,v 1.7 2009/02/20 10:08:38 lulin Exp $}

// $Log: vtGradientWaitbar.pas,v $
// Revision 1.7  2009/02/20 10:08:38  lulin
// - чистка комментариев.
//
// Revision 1.6  2009/02/09 11:54:59  oman
// - fix: Защищаемся от многопоточности (К-136259551)
//
// Revision 1.5  2008/08/06 14:05:28  lulin
// - боремся с <K>: 106038039.
//
// Revision 1.4  2005/04/20 08:52:15  mmorozov
// change: вся функциональность перенесена в Tl3GradientWaitbar, компонент теперь только рисует;
//
// Revision 1.3  2005/03/28 14:28:18  migel
// - change: закоментировали неиспользуемые переменные (чтобы компилятор не выдалвал предупреждения).
//
// Revision 1.2  2004/07/15 10:37:57  fireton
// - bug fix: системные цвета теперь поддерживаются
//
// Revision 1.1  2004/07/15 09:16:45  fireton
// - new _module: бегущий градиент
//

interface

uses
  Windows,
  Messages,
  Graphics,
  Classes,
  Controls,

  l3GradientWaitbar
  ;

type
  TvtGradientWaitbar = class(TGraphicControl)
  private
  // internal fields
    f_Waitbar : Tl3GradientWaitbar;
    f_InPaint : Boolean;
    procedure SetSpeed(const Value: Integer);
  private
  // internal methods
    procedure WaitbarPaint(Sender : TObject);
      {-}
  private
  // property methods
    function GetActive: Boolean;
      {-}
    procedure SetActive(const Value: Boolean);
      {-}
    procedure SetColor1(const Value: TColor);
      {-}
    procedure SetColor2(const Value: TColor);
      {-}
    function GetColor1: TColor;
      {-}
    function GetColor2: TColor;
      {-}
    function GetSpeed: Integer;
      {-}
  protected
  // protected methods
   procedure Paint;
     override;
     {-}
   procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
     override;
     {-}
  public
  // public methods
    constructor Create(AOwner : TComponent);
      override;
      {-}
    destructor Destroy;
      override;
      {-}
   procedure ManualProgress(Progress: Integer);
     {-}
  published
  // published property
   property Active: Boolean
     read GetActive
     write SetActive;
     {-}
   property Color1: TColor
     read GetColor1
     write SetColor1;
     {-}
   property Color2: TColor
     read GetColor2
     write SetColor2;
     {-}
   property Speed: Integer
     read GetSpeed
     write SetSpeed
     default 1;
     {-}
   property Anchors;
     {-}
  end;

implementation

uses
  l3Base
  ;

{ TvtGradientWaitbar }

constructor TvtGradientWaitbar.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 f_Waitbar := Tl3GradientWaitbar.Create;
 f_Waitbar.OnPaint := WaitbarPaint;
 ControlStyle := ControlStyle + [csOpaque];
 SetBounds(Left, Top, 150, 25);
end;

destructor TvtGradientWaitbar.Destroy;
// override;
{-}
begin
 l3Free(f_Waitbar);
 inherited;
end;

procedure TvtGradientWaitbar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
//override;
{-}
begin
 inherited;
 f_Waitbar.SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TvtGradientWaitbar.Paint;
begin
 if not f_InPaint then
 begin
  f_InPaint := true;
  try
   Canvas.Lock;
   f_Waitbar.BackBuf.Canvas.Lock;

   BitBlt(Canvas.Handle, 0, 0, Width, Height, f_Waitbar.BackBuf.Canvas.Handle, 0,
    0, cmSrcCopy);

   f_Waitbar.BackBuf.Canvas.UnLock;
   Canvas.UnLock;
  finally
   f_InPaint := false;
  end;//try..finally
 end;//not f_InPaint
end;

function TvtGradientWaitbar.GetColor1: TColor;
begin
 Result := f_Waitbar.Color1;
end;

function TvtGradientWaitbar.GetColor2: TColor;
begin
 Result := f_Waitbar.Color2;
end;

function TvtGradientWaitbar.GetSpeed: Integer;
begin
 Result := f_Waitbar.Speed;
end;

procedure TvtGradientWaitbar.SetColor1(const Value: TColor);
begin
  f_Waitbar.Color1 := Value;
end;

procedure TvtGradientWaitbar.SetColor2(const Value: TColor);
begin
  f_Waitbar.Color2 := Value;
end;

function TvtGradientWaitbar.GetActive: Boolean;
begin
 Result := f_Waitbar.Active;
end;

procedure TvtGradientWaitbar.SetActive(const Value: Boolean);
begin
 f_Waitbar.Active := Value;
end;

procedure TvtGradientWaitbar.SetSpeed(const Value: Integer);
begin
 f_Waitbar.Speed := Value;
end;

procedure TvtGradientWaitbar.WaitbarPaint(Sender: TObject);
begin
 Paint;
end;

procedure TvtGradientWaitbar.ManualProgress(Progress: Integer);
begin
 f_Waitbar.ManualProgress(Progress);
end;

end.
