{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dcddes, Menus, dcfdes;

type
  TDataModule2 = class(TDataModule)
    DreamDesigner1: TDreamDesigner;
    MainMenu1: TMainMenu;
    PopupMenu1: TPopupMenu;
    ImageList1: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule2: TDataModule2;

implementation

{$R *.DFM}

end.
