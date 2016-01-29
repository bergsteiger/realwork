{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcmemopt;

interface

uses
  dcMemo;

var
  FMemoOptions: TMemoEnvOptions;

implementation

uses dcConsts, dcCommon, dcEditorOpt, dcDisplayOpt, dcColorsOpt;

initialization
  GlobalMemoOptions;

  FMemoOptions := TMemoEnvOptions.Create;

  RegisterOptionsFormOrder(TEditorOptForm, 2, SEditor);
  RegisterOptionsFormOrder(TDisplayOptForm, 3, SDisplay);
  RegisterOptionsFormOrder(TColorsOptForm, 4, SColors);
finalization
  FMemoOptions.Free;
end.
