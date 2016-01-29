unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TMainForm = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R nsSettings.res}

uses
  l3Types,
  l3Base,
  l3BaseStream,
  l3Stream,

  evTypes,
  evEditorWindow,
  evEditor,
  evStyleTableTools,

  DSign,
  nsSignControl
  ;

{$R *.dfm}

type
  TsgnEditor = class(TevEditor)
    private
    // message handlers
      procedure WMPaint(var Message: TWMPaint);
        message WM_PAINT;
        {-}
  end;//TsgnEditor

// start class TsgnEditor

procedure TsgnEditor.WMPaint(var Message: TWMPaint);
  //message WM_PAINT;
  {-}

begin
 if (Message.DC <> 0) then
  inherited
 else
  SignControl(Self);
end;

// start class TMainForm

procedure TMainForm.FormCreate(Sender: TObject);
var
 l_Editor : TsgnEditor;
 l_Stream : Tl3Stream;
begin
 l_Editor := TsgnEditor.Create(Self);
 l_Editor.Align := alClient;
 l_Editor.LeftIndentDelta := 16;
 l_Editor.TextSource := TevTextSource.Create(Self);
 l_Editor.Parent := Self;
 //l_Editor.Color := clBlue;
 //l_Editor.Color := clSkyBlue;
 //l_Editor.Color := clMoneyGreen;
 l_Editor.Color := clCream;
 //l_Editor.Color := $EEEEEE{! - дл€ €ркостей дает неплохой результат};
 //l_Editor.Color := $BBBBBB;
 //l_Editor.Color := $CBF7F9;
 //l_Editor.Color := $ECFFFC;
 //l_Editor.Color := $D9FCE6;
 //l_Editor.Color := //$AEEABD;//$BAEDBE;
 //l_Editor.Color := clMedGray;
 l_Stream := Tl3FileStream.Create('.\1.evd', l3_fmRead);
 try
  l_Editor.TextSource.WriteData(cf_EverestBin, l_Stream);
 finally
  l3Free(l_Stream);
 end;//try..finally
 l_Stream := Tl3ResourceStream.Create(HInstance, 'nsDefaultStyleTable');
 try
  with TevStyleInterface.Make do
   try
    //Load(l_Stream);
   finally
    Free;
   end;
 finally
  l3Free(l_Stream);
 end;//try..finally
end;

end.
