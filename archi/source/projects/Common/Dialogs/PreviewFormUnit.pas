unit PreviewFormUnit;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,

  OvcBase,

  arCommonTypes,

  afwControlPrim,
  afwBaseControl,
  afwControl,
  afwCustomCommonControlPrim,
  afwCustomCommonControl,

  vtPreviewPanel;

type
  TPreviewForm = class(TForm)
    vtPreviewPanel1: TvtPreviewPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    f_LinkOwner: Pointer;
     {-}
    procedure SetLinkOwner(const Value: IevClearPreviewLink);
    { Private declarations }
  public
    { Public declarations }
   procedure StopPreivew;
    {-}
   property PreviewLinkOwner: IevClearPreviewLink write SetLinkOwner;
    {-}
  end;

implementation

{$R *.dfm}

procedure TPreviewForm.FormCreate(Sender: TObject);
begin
 if Owner <> nil then
  Caption := Caption + (Owner as TForm).Caption;
 f_LinkOwner := nil; 
end;

procedure TPreviewForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 StopPreivew;
end;

procedure TPreviewForm.StopPreivew;
begin
 if (vtPreviewPanel1.Preview <> nil) AND vtPreviewPanel1.Preview.InProcess then
  vtPreviewPanel1.Preview.Stop(Handle);
end;

procedure TPreviewForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action := caFree;
 if f_LinkOwner <> nil then
  IevClearPreviewLink(f_LinkOwner).ClearPreview;
 f_LinkOwner := nil; 
end;

procedure TPreviewForm.SetLinkOwner(const Value: IevClearPreviewLink);
begin
 f_LinkOwner := Pointer(Value);
end;

end.
