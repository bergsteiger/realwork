unit readerForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit;

type
  TForm1 = class(TForm)
    Button1: TButton;
    DirectoryEdit1: TDirectoryEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var                                                       
  Form1: TForm1;

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
 k2TagGen,
 k2TagTerminator,

 evdReader,
 ddUtils;

{$R *.dfm}

type
 TProgressFilter = Class(Tk2TagTerminator)
 public
   procedure AddAtomEx(AtomIndex : Long; const Value : Tk2Variant); override;
 end;

procedure TProgressFilter.AddAtomEx(AtomIndex : Long; const Value : Tk2Variant);
begin
 Generator.AddAtomEx(AtomIndex,Value);
 if (AtomIndex = k2_tiInternalHandle) and
     TopType[0].InheritsFrom(k2_idDocument) then
     l3system.Msg2Log('Topic %d', [Value.AsInteger]);

     ;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
 l_Filer: Tl3CustomFiler;
 l_Reader: TevdNativeReader;
 l_Start: TDateTime;
 l_SR: TSearchRec;
 l_Dummy: Tk2TagGenerator;
 l_Count: Integer;
 l_ProgressFilter : TProgressFilter;
begin
 Label1.Caption := '';
 l3system.Msg2Log('');
 l3system.Msg2Log('__________Start____________');

 l_Reader:= TevdNativeReader.Create(nil);
 try
  l_Filer:= Tl3DOSFiler.Create(nil);
  //l_Filer:= Tl3WindowsStorageFiler.Create(nil);
  try
   l_Dummy:= Tk2TagGenerator.Create(nil);
   try
    //TProgressFilter.SetTo(l_Dummy);                    l3filer
    //l_Reader.Generator:= l_Dummy;
    l_Reader.Filer:= l_Filer;
    l_Start:= Now;
    l_Count:= 0;
     if FindFirst(ConcatDirName(DirectoryEdit1.Text, '*.evd'), faAnyFile, l_SR) = 0 then
      repeat
       if l_SR.Attr and faDirectory <> faDirectory then
       begin
        Inc(l_Count);
        Tl3DOSFiler(l_Filer).FileName := ConcatDirName(DirectoryEdit1.Text, l_SR.Name);
        l3system.Msg2Log('File %s', [Tl3DOSFiler(l_Filer).FileName]);
        l_Filer.Open;
        l_Reader.Start;
        try
         l_Reader.Read;
        finally
         l_Reader.Finish;
        end;
        l_Filer.Close;
       end; // l_SR.Attr and faDirectory <> faDirectory
      until FindNext(l_SR) <> 0;
     Label1.Caption := 'Процесс занял ' + TimeSec2Str(SecondsBetween(Now, l_Start)) + ' ('+ IntToStr(l_Count)+')';
     l3system.Msg2Log(Label1.Caption);
     FindClose(l_SR);
   finally
    l3Free(l_Dummy);
   end;
  finally
   l3Free(l_Filer);
  end;
 finally
  l3Free(l_Reader);
 end;
end;


end.
