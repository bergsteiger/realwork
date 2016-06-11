{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzureMessageDialog;

interface

uses
  Vcl.Buttons, System.Classes, Vcl.Controls, DSAzureQueue, Vcl.ExtCtrls, Vcl.Forms, Vcl.Graphics,
  Vcl.Grids, Vcl.StdCtrls, Vcl.ValEdit;

type
  TAzureMsgDialog = class(TForm)
    ValueList: TValueListEditor;
    closeButton: TButton;
    procedure closeButtonClick(Sender: TObject);
  public
    procedure SetMessage(Msg: TMessageNodeData);
  end;

implementation

{$R *.dfm}

uses System.SysUtils;

const
  MSG_ID = 'MessageId=';
  MSG_INSERT = 'InsertionTime=';
  MSG_EXPIRE = 'ExpirationTime=';
  MSG_DEQUE = 'DequeueCount=';
  MSG_TEXT = 'MessageText=';

{ TAzureMsgDialog }

procedure TAzureMsgDialog.closeButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TAzureMsgDialog.SetMessage(Msg: TMessageNodeData);
begin
  ValueList.Strings.BeginUpdate;
  try
    ValueList.Strings.Clear;

    ValueList.Strings.Add(MSG_ID + Msg.MessageId);
    ValueList.Strings.Add(MSG_INSERT + Msg.InsertTime);
    ValueList.Strings.Add(MSG_EXPIRE + Msg.ExpireTime);
    ValueList.Strings.Add(MSG_DEQUE + IntToStr(Msg.DequeueCount));
    ValueList.Strings.Add(MSG_TEXT + Msg.MessageText);
  finally
    ValueList.Strings.EndUpdate;
  end;
end;

end.
