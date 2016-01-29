unit vtVGSceneRes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vg_scene, vgComponent, vgCustomResources;

type
  TvtVGSceneResources = class(TDataModule)
    vgResources: TvgResources;
  end;

 function vtVGSceneResources: TvtVGSceneResources;

var
 vtStdVGSceneResources : TvtVGSceneResources = nil;
 
const
 cButtonStyleLayoutName = 'buttonstyle';
 cCheckBoxStyleLayoutName = 'checkboxstyle';
 cCalloutPanelStyleLayoutName = 'calloutpanelstyle';
 cCalloutPanelWarningStyleLayoutName = 'calloutpanelwarningstyle';
 cCloseButtonWarningStyleLayoutName = 'closebuttonwarningstyle';

implementation

uses
  l3Base
  ;

{$R *.DFM}

procedure Fini;
begin
 FreeAndNil(vtStdVGSceneResources);
end;

function vtVGSceneResources: TvtVGSceneResources;
begin
 Assert(not l3SystemDown);
 if (vtStdVGSceneResources = nil) then
 begin
  vtStdVGSceneResources := TvtVGSceneResources.Create(nil);
  l3System.AddExitProc(Fini);
 end;//vtStdVGSceneResources = nil
 Result := vtStdVGSceneResources;
end;

end.
