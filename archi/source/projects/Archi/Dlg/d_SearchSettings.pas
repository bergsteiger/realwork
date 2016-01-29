unit d_SearchSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BOTTOMBTNDLG, StdCtrls, Buttons, ExtCtrls,
  dt_Types, dt_AttrSchema;

type
  TSearchSettingsDlg = class(TBottomBtnDlg)
    rgLinkDate: TRadioGroup;
    rgDict: TRadioGroup;
  private
    function pm_GetFilterDict: TdtAttribute;
    function pm_GetRangedLinkDate: Boolean;
    procedure pm_SetFilterDict(const Value: TdtAttribute);
    procedure pm_SetRangedLinkDate(const Value: Boolean);
    { Private declarations }
  public
    property FilterDict: TdtAttribute read pm_GetFilterDict write pm_SetFilterDict;
    property RangedLinkDate: Boolean read pm_GetRangedLinkDate write pm_SetRangedLinkDate;
    { Public declarations }
  end;

var
  SearchSettingsDlg: TSearchSettingsDlg;

implementation
{$R *.dfm}

function TSearchSettingsDlg.pm_GetFilterDict: TdtAttribute;
begin
 case rgDict.ItemIndex of
  0 : Result := atAccGroups;
  1 : Result := atBases;
 end;
end;

function TSearchSettingsDlg.pm_GetRangedLinkDate: Boolean;
begin
 Result := (rgLinkDate.ItemIndex = 1);
end;

procedure TSearchSettingsDlg.pm_SetFilterDict(const Value: TdtAttribute);
begin
 case Value of
  atAccGroups: rgDict.ItemIndex := 0;
  atBases    : rgDict.ItemIndex := 1;
 end;
end;

procedure TSearchSettingsDlg.pm_SetRangedLinkDate(const Value: Boolean);
begin
 if Value then
  rgLinkDate.ItemIndex := 1
 else
  rgLinkDate.ItemIndex := 0;
end;

end.
