unit fcChangeLink;

interface

uses Classes;

type
  TfcChangeLink = class(TObject)
  private
    FOnChange: TNotifyEvent;
    FOnChanging: TNotifyEvent;
    FOnLoaded: TNotifyEvent;
    FSender: TObject;
  public
    procedure Change; virtual;
    procedure Changing; virtual;
    procedure Loaded; virtual;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChanging: TNotifyEvent read FOnChanging write FOnChanging;
    property OnLoaded: TNotifyEvent read FOnLoaded write FOnLoaded;
    property Sender: TObject read FSender write FSender;
  end;

implementation

procedure TfcChangeLink.Change;
begin
  if Assigned(OnChange) then OnChange(Sender);
end;

procedure TfcChangeLink.Changing;
begin
  if Assigned(OnChanging) then OnChanging(Sender);
end;

procedure TfcChangeLink.Loaded;
begin
  if Assigned(OnLoaded) then OnLoaded(Sender);
end;

end.
