{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCSelMenuUnit;

interface
{$I dc.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Menus,

  DCButtonPanel, DCConsts,
  DCImageListBox;

type
  TDCSelectMenuForm = class(TForm)
    DCButtonPanel1: TDCButtonPanel;
    ListBox: TDCImageListBox;
    OkBtn: TBitBtn;
    CancelBtn: TBitBtn;
    procedure ListBoxChanged(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    Constructor Create( AOwner : TComponent ); override;
  end;

Function ChooseMenu( AOwner : TComponent; ACurrentMenu : TMenu ) : TMenu;

implementation

{$R *.DFM}

{------------------------------------------------------------------}

Function ChooseMenu( AOwner : TComponent; ACurrentMenu : TMenu ) : TMenu;
Var
  I : Integer;
begin
  Result := ACurrentMenu; 
  With TDCSelectMenuForm.Create( Application ) Do
    try
      With AOwner Do
        For I := 0 To ComponentCount - 1 Do
          If Components[ I ].InheritsFrom( TMenu ) Then
            With TDCImageListItem( ListBox.Items.Add ) Do
            begin
              Caption := Components[ I ].Name;
              UserData := Components[ I ];
              If ACurrentMenu = Components[ I ] Then
                ListBox.ItemIndex := I;
            end;
      If ShowModal = mrOk Then
        With ListBox Do
          Result := TDCImageListItem( Items[ ItemIndex ] ).UserData;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

{ TDCSelectMenuForm }

Constructor TDCSelectMenuForm.Create( AOwner : TComponent );
begin
  Inherited;
  Caption := sDCSelectMenuFormCaption;
end;

{------------------------------------------------------------------}

procedure TDCSelectMenuForm.ListBoxChanged(Sender: TObject);
begin
  OkBtn.Enabled := ListBox.ItemIndex >= 0;
end;

{------------------------------------------------------------------}

procedure TDCSelectMenuForm.ListBoxDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

{------------------------------------------------------------------}

end.
