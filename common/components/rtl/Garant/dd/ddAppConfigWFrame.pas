unit ddAppConfigWFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, OvcBase, afwControl, vtPanel;

type
  TWorkFrame = class(TFrame)
    CaptionPanel: TvtPanel;
    ComponentsPanel: TvtPanel;
  private
  // property methods
    function pm_GetHeaderHeight : Integer;
      {-}
  public
  // public methods
    property HeaderHeight : Integer
      read pm_GetHeaderHeight;
      {-}
  end;
  
implementation

{$R *.dfm}

{ TWorkFrame }

function TWorkFrame.pm_GetHeaderHeight : Integer;
begin
 Result := CaptionPanel.Height;
end;

end.