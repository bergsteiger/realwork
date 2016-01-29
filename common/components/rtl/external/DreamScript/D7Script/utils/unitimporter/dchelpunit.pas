{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCHelpUnit;

{$I DC.inc}

interface

uses
  StdCtrls, Buttons, Controls, ExtCtrls, Classes, Forms,

  DCButtonPanel, DCConsts,
  DCImportConsts;

type
  TDCImportHelpForm = class(TForm)
    HelpMemo: TMemo;
    ControlPanel: TDCButtonPanel;
    TopPanel: TPanel;
    LeftPanel: TPanel;
    RightPanel: TPanel;
    CloseBtn: TBitBtn;
  private
    { Private declarations }
  public
    Constructor Create( AOwner : TComponent ); override;
  end;

Procedure ShowCommandLineHelp;

implementation

{$R *.DFM}

{------------------------------------------------------------------}

Procedure ShowCommandLineHelp;
begin
  With TDCImportHelpForm.Create( Nil ) Do
  try
    ShowModal;
  finally
    Free;
  end;
end;

{------------------------------------------------------------------}

{ THelpForm }

Constructor TDCImportHelpForm.Create( AOwner : TComponent );
Var
  I : Integer;
begin
  Inherited;

  Caption := sDCImportHelpFormCaption;
  For I := 0 To sDCImportHelpContextLine - 1 Do
    HelpMemo.Lines.Add( sDCImportHelpContext[ I ] );
  CloseBtn.Caption := sDCCloseButton;
end;

{------------------------------------------------------------------}

end.
