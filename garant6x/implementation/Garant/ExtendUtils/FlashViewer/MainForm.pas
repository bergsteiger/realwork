unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OvcBase, afwControlPrim, afwBaseControl, afwControl,
  afwTextControlPrim, afwTextControl, vtPanel, StdCtrls, Mask, ToolEdit,

  vtShockwaveFlashEx, ExtCtrls, vtLabel
  ;

type
  TfmMain = class(TForm)
    Header: TvtPanel;
    Client: TvtPanel;
    btLoad: TButton;
    edFileName: TFilenameEdit;
    lbWidth: TvtLabel;
    lbHeight: TvtLabel;
    Timer: TTimer;
    Box: TScrollBox;
    lbCommand: TvtLabel;
    procedure FormDestroy(Sender: TObject);
    procedure btLoadClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure edFileNameAfterDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    f_Flash : TvtShockwaveFlashEx;
    procedure OnLoadFlash(ASender: TObject);
      {* - загрузить ролик по требованию. }
   procedure OnFSCommand(aSender: TObject;
    const command: WideString;
    const args: WideString);
     {* обработка ссылок в ролике }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses
  FlashUtils,

  l3Types,
  l3Stream,
  l3IniFile
  ;

{$R *.dfm}

procedure TfmMain.FormCreate(Sender: TObject);
begin
 InitUserConfig;
 UserConfig.Section := 'Config';
 edFileName.InitialDir := UserConfig.ReadParamStrDef('InitialDir', edFileName.InitialDir);
 edFileName.Text := UserConfig.ReadParamStrDef('Text', edFileName.Text);
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
 UserConfig.Section := 'Config';
 UserConfig.WriteParamStr('Text', edFileName.Text);
 UserConfig.WriteParamStr('InitialDir', edFileName.InitialDir);
 FreeAndNil(f_Flash);
end;

procedure TfmMain.OnLoadFlash(ASender: TObject);
  {* - загрузить ролик по требованию. }
var
 l_Stream : Tl3NamedTextStream;  
begin
 Assert(f_Flash <> nil);
 l_Stream := Tl3NamedTextStream.Create(edFileName.Text, l3_fmRead);
 try
  f_Flash.LoadMovieFromStream(l_Stream);
  f_Flash.Stop;
  f_Flash.Repaint;
 finally
  FreeAndNil(l_Stream);
 end;//try..finally
end;

procedure TfmMain.OnFSCommand(aSender: TObject;
 const command: WideString;
 const args: WideString);
begin
 lbCommand.Caption := command + ': ' + args;
end;

procedure TfmMain.btLoadClick(Sender: TObject);
begin
 Timer.Enabled := false;
 FreeAndNil(f_Flash);
 NsMakeFlashActiveX(Box, false, f_Flash);
 if (f_Flash <> nil) then
 begin
  Timer.Enabled := true;
  f_Flash.OnLoadFlash := Self.OnLoadFlash;
  f_Flash.OnFSCommand := Self.OnFSCommand;
  f_Flash.LoadByRequest
 end;//f_Flash <>
end;

procedure TfmMain.TimerTimer(Sender: TObject);
begin
 if (f_Flash <> nil) then
 begin
  lbWidth.Caption := IntToStr(f_Flash.LoadedWidth);
  lbHeight.Caption := IntToStr(f_Flash.LoadedHeight);
 end;//f_Flash <> nil
end;

procedure TfmMain.edFileNameAfterDialog(Sender: TObject; var Name: String;
  var Action: Boolean);
begin
 if Action then
  btLoadClick(Sender);
end;

end.