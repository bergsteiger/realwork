{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$I ..\ElPack.inc}

unit ElDBNavDsgn;

interface

uses ElToolBar, ElDBCtrls,
{$ifdef VCL_6_USED}
  DesignIntf, DesignEditors, DesignWindows, DsnConst
{$else}
  DsgnIntf
{$endif}
;

type
  TElDBNavigatorEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer) : string; override;
    function GetVerbCount : Integer; override;
  end;

implementation

//type
//  THackButton = class(TElDBNavButton);

procedure TElDBNavigatorEditor.ExecuteVerb(Index : Integer);
  var
    ElDBNav        : TElDBNavigator;
    ElDBNavBtn     : TElDBNavButton;
    ElDBNavBtnPrev : TElDBNavButton;
    i              : integer;

    TBar : TElToolBar;
    TButton : TElToolButton;

begin
  if Index = 0 then
  begin
        ElDBNav := Component as TElDBNavigator;
        ElDBNavBtn :=  Designer.CreateComponent(TElDBNavButton, ElDBNav, 10000, 10000, ElDBNav.BtnWidth, ElDBNav.BtnHeight) as TElDBNavButton;
        // Set Next Role
          ElDBNavBtnPrev := nil;
          // scan previous Role
          for i:=ElDBNav.ButtonCount-2 DownTo 0 do
            begin
              if ElDBNav.CustomToolButton[i] is TElDBNavButton then
               begin
                 ElDBNavBtnPrev := TElDBNavButton(ElDBNav.ToolButton[i]);
                 break;
               end;
            end;
          // assign role
          if ElDBNavBtnPrev=nil
            then ElDBNavBtn.Role := nbrFirst
            else
             begin
                if ElDBNavBtnPrev.Role < nbrCustom //High(TElNavButtonRole)
                  then ElDBNavBtn.Role := Succ(ElDBNavBtnPrev.Role);
             end;
  end
  else begin
        TBar := TElToolBar(Component);
        TButton := TElToolButton(Designer.CreateComponent(TElToolButton, TBar, 10000, 10000, TBar.BtnWidth, TBar.BtnHeight));
        if Assigned(TButton) then
        begin
          if Index = 1 then
            TButton.ButtonType := ebtSeparator
          else
            TButton.ButtonType := ebtDivider;
        end;
  end;
end;

//TElToolButtonType = (ebtButton, ebtSeparator, ebtDivider);

function TElDBNavigatorEditor.GetVerb(Index : Integer): string;
begin
  if Index = 0 then
    Result := 'New DB B&utton'
  else
  if Index = 1 then
    Result := 'New S&eparator'
  else
  if Index = 2 then
    Result := 'New D&ivider'
end;

function TElDBNavigatorEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;

end.
