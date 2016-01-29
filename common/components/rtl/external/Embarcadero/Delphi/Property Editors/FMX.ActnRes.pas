{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.ActnRes;

interface

uses
  System.SysUtils, System.Classes, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.Types;

type
  TStandardActions = class(TDataModule)
    ActionList: TActionList;
    ViewAction1: TViewAction;
    VirtualKeyboard1: TVirtualKeyboard;
    FileExit1: TFileExit;
    FileHideApp1: TFileHideApp;
    WindowClose1: TWindowClose;
    FileHideAppOthers1: TFileHideAppOthers;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
