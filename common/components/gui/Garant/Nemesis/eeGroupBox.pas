unit eeGroupBox;

interface

uses
  Classes,
  Messages,

  vtGroupBox
  ;

type
  TeeGroupBox = class(TvtGroupBox)
  private
    procedure WMEraseBkgnd(var Message : TWMEraseBkgnd);
      message WM_ERASEBKGND;
      {-}
  public
    constructor Create(AOwner : TComponent);
      override;
      {-}
    procedure Paint;
      override;
      {-}
  end;//TeeGroupBox

implementation

uses
  Graphics
  ;

// start class TeeGroupBox 

constructor TeeGroupBox.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
end;

procedure TeeGroupBox.Paint;
begin
 with Canvas do
 begin
  Brush.Color := Color;
  FillRect(ClientRect);
 end;
 inherited;
end;

procedure TeeGroupBox.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
 Message.Result := Integer(True);
end;

end.
