unit MobileInternetVersionMenuForm_Unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vtHoverButton, ImgList, vtPngImgList, tb97ctls, ExtCtrls;

type
  TmivUserCommand = (mucCancel, mucStartWorkingWithInternetVersion, mucObtainRequisites,
    mucWorkLocal, mucRunContractConstructor);

  TProcessCommandProc = procedure(ACommand: TmivUserCommand) of object;

  TMobileInternetVersionMenuForm = class(TForm)
    WorkLocalButtonImages: TvtNonFixedPngImageList;
    ObtainRequisitesButtonImages: TvtNonFixedPngImageList;
    StartButtonImages: TvtNonFixedPngImageList;
    BackgroundImages: TvtNonFixedPngImageList;
    ContractConstructorButtonImages: TvtNonFixedPngImageList;
  private
    f_pbBackground: TPaintBox;
    f_StartButton: TvtHoverButton;
    f_ObtainRequisitesButton: TvtHoverButton;
    f_WorkLocalButton: TvtHoverButton;
    f_ContractConstrutorButton: TvtHoverButton;
    f_OnCommand: TProcessCommandProc;
    procedure StartButtonClick(ASender: TObject);
    procedure ObtainRequisitesButtonClick(ASender: TObject);
    procedure WorkLocalButtonClick(ASender: TObject);
    procedure ContractConstructorButtonClick(ASender: TObject);
    procedure PaintBackground(ASender: TObject);
    procedure SendCommand(ACommand: TmivUserCommand);
  protected
    procedure InitControls;
    procedure Loaded; override;
  public
    property OnCommand: TProcessCommandProc read f_OnCommand write f_OnCommand;
  end;

implementation

{$R *.dfm}

procedure TMobileInternetVersionMenuForm.ObtainRequisitesButtonClick(ASender: TObject);
begin
 SendCommand(mucObtainRequisites);
end;//TMobileInternetVersionMenuForm.ObtainRequisitesButtonClick

procedure TMobileInternetVersionMenuForm.StartButtonClick(ASender: TObject);
begin
 SendCommand(mucStartWorkingWithInternetVersion);
end;//TMobileInternetVersionMenuForm.StartButtonClick

procedure TMobileInternetVersionMenuForm.WorkLocalButtonClick(ASender: TObject);
begin
 SendCommand(mucWorkLocal);
end;//TMobileInternetVersionMenuForm.WorkLocalButtonClick

procedure TMobileInternetVersionMenuForm.ContractConstructorButtonClick(ASender: TObject);
begin
 SendCommand(mucRunContractConstructor);
end;//TMobileInternetVersionMenuForm.ContractConstructorButtonClick

procedure TMobileInternetVersionMenuForm.InitControls;
const
 C_SMALL_BUTTON_VERITCAL_SPACING = 8;
var
 l_ClientHorCenter: Integer;
begin
 ClientHeight := 600;
 ClientWidth := 720;
 Position := poScreenCenter;

 l_ClientHorCenter := ClientWidth div 2;

 f_pbBackground := TPaintBox.Create(Self);
 with f_pbBackground do
 begin
  Parent := Self;
  Align := alClient;
  OnPaint := PaintBackground;
 end;//with f_pbBackground

 f_StartButton := TvtHoverButton.Create(Self);
 with f_StartButton do
 begin
  DoubleBuffered := True;
  Parent := Self;
  Left := l_ClientHorCenter - (StartButtonImages.Width div 2);
  Top := 254;
  AutoSize := True;
  ImageList := StartButtonImages;
  NormalImageIndex := 0;
  HoveredImageIndex := 1;
  PressedImageIndex := 1;
  OnClick := StartButtonClick;
 end;//with f_StartButton

 f_ObtainRequisitesButton := TvtHoverButton.Create(Self);
 with f_ObtainRequisitesButton do
 begin
  DoubleBuffered := True;
  Parent := Self;
  Left := l_ClientHorCenter - (ObtainRequisitesButtonImages.Width div 2);
  Top := 331;
  AutoSize := True;
  ImageList := ObtainRequisitesButtonImages;
  NormalImageIndex := 0;
  HoveredImageIndex := 1;
  PressedImageIndex := 1;
  OnClick := ObtainRequisitesButtonClick;
 end;//with f_ObtainRequisitesButton

 f_WorkLocalButton := TvtHoverButton.Create(Self);
 with f_WorkLocalButton do
 begin
  DoubleBuffered := True;
  Parent := Self;
  Left := 365;
  Top := 430;
  AutoSize := True;
  ImageList := WorkLocalButtonImages;
  NormalImageIndex := 0;
  HoveredImageIndex := 1;
  PressedImageIndex := 1;
  OnClick := WorkLocalButtonClick;
 end;//with f_WorkLocalButton

 f_ContractConstrutorButton := TvtHoverButton.Create(Self);
 with f_ContractConstrutorButton do
 begin
  DoubleBuffered := True;
  Parent := Self;
  Left := f_WorkLocalButton.Left;
  Top := f_WorkLocalButton.Top + f_WorkLocalButton.Height +
   C_SMALL_BUTTON_VERITCAL_SPACING;
  AutoSize := True;
  ImageList := ContractConstructorButtonImages;
  NormalImageIndex := 0;
  HoveredImageIndex := 1;
  PressedImageIndex := 1;
  OnClick := ContractConstructorButtonClick;
 end;//with f_ContractConstrutorButton 

end;//TMobileInternetVersionMenuForm.InitControls

procedure TMobileInternetVersionMenuForm.Loaded;
begin
 inherited;
 InitControls;
end;//TMobileInternetVersionMenuForm.Loaded;

procedure TMobileInternetVersionMenuForm.PaintBackground(ASender: TObject);
begin
 BackGroundImages.Draw(f_pbBackground.Canvas, 0, 0, 0);
end;//TMobileInternetVersionMenuForm.PaintBackground

procedure TMobileInternetVersionMenuForm.SendCommand(
  ACommand: TmivUserCommand);
begin
 if (Assigned(f_OnCommand)) then
  f_OnCommand(ACommand)
 else
  Assert(False);
end;//TMobileInternetVersionMenuForm.SendCommand

end.
