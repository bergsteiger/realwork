unit FindForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit;

type
  TFindMainForm = class(TForm)
    StartButton: TButton;
    FindDriSelector: TDirectoryEdit;
    Progress: TLabel;
    procedure StartButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure FindDocument(aFindEVD: Boolean);
  public
    { Public declarations }
  end;

var                                                       
  FindMainForm: TFindMainForm;

implementation

uses
 DateUtils,

 Document_Const,

 l3Types,
 l3Filer,
 l3Base,
 l3FileUtils,

 k2Types,
 k2Tags,
 k2Reader,
 k2TagGen,
 k2TagTerminator,

 evTableCheckerFilter,

 evdReader,
 
 ddNSRC_r,
 ddUtils;

{$R *.dfm}

type
 TevCustomFileParserHack = class(Tk2CustomFileParser);

procedure TFindMainForm.FindDocument(aFindEVD: Boolean);
const
 csEVDMask = '*.evd';
 csNSRCMask = '*.nsr';
var
 l_SR        : TSearchRec;
 l_Mask      : AnsiString;
 l_Start     : TDateTime;
 l_Count     : Integer;
 l_Filer     : Tl3CustomFiler;
 l_Reader    : Tk2CustomFileParser;
 l_Generator : Tk2TagGenerator;
begin
 if aFindEVD then
 begin
  l_Reader:= TevdNativeReader.Create(nil);
  l_Mask := csEVDMask;
 end // if aFindEVD then
 else
 begin
  l_Reader:= TCustomNSRCReader.Create(nil);
  l_Mask := csNSRCMask;
 end; 
 try
  l_Filer := Tl3DOSFiler.Create(nil);
  try
   l_Generator := nil;
   TevTableCheckerFilter.SetTo(l_Generator);
   (l_Reader As Ik2TagGeneratorChainEnd).Link(l_Generator);
   try
    l_Reader.Filer := l_Filer;
    l_Start := Now;
    l_Count := 0;
    if FindFirst(ConcatDirName(FindDriSelector.Text, l_Mask), faAnyFile, l_SR) = 0 then
     repeat
      if l_SR.Attr and faDirectory <> faDirectory then
      begin
       Inc(l_Count);
       Tl3DOSFiler(l_Filer).FileName := ConcatDirName(FindDriSelector.Text, l_SR.Name);
       g_SetDocName(Tl3DOSFiler(l_Filer).FileName);
       l_Filer.Open;
       l_Reader.Start;
       try
        TevCustomFileParserHack(l_Reader).Read;
       finally
        l_Reader.Finish;
       end;
       l_Filer.Close;
      end; // l_SR.Attr and faDirectory <> faDirectory
     until FindNext(l_SR) <> 0;
    Progress.Caption := 'Проверили...';
    FindClose(l_SR);
   finally
    l3Free(l_Generator);
   end;
  finally
   l3Free(l_Filer);
  end;
 finally
  l3Free(l_Reader);
 end;
end;

procedure TFindMainForm.StartButtonClick(Sender: TObject);
begin
 Progress.Caption := '';
 l3system.Msg2Log('');
 l3system.Msg2Log('__________Start____________');
 FindDocument(True);
 FindDocument(False);
end;


end.
