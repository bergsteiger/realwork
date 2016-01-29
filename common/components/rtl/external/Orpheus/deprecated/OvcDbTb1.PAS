{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCDBTB1.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcDbTb1;

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, OvcBase, OvcEF, OvcSF, ExtCtrls,
  OvcIntl;

type
  TfrmProperties = class(TForm)
    edPictureMask: TOvcSimpleField;
    OvcController1: TOvcController;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edDecimalPlaces: TOvcSimpleField;
    rgDateOrTime: TRadioGroup;
    procedure rgDateOrTimeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmProperties.rgDateOrTimeClick(Sender: TObject);
var
  ForceCentury : Boolean;
begin
   ForceCentury := Pos('yyyy', ShortDateFormat) > 0;
   if rgDateOrTime.ItemIndex = 0 then
     edPictureMask.AsString := OvcIntlSup.InternationalDate(ForceCentury)
   else
     edPictureMask.AsString := OvcIntlSup.InternationalTime(False);
end;

end.
