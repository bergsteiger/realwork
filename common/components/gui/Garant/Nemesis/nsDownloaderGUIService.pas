//http://www.garant.ru/products/solution/mobile_tech/

unit nsDownloaderGUIService;

interface
uses
 l3ProtoObject,
 nsDownloaderInterfaces;

type
 InsDownloaderGUIService = Interface(IUnknown)
  ['{5D837538-B682-4C02-8E11-ECA6914ED3CB}']
  function EditParams(const AParams: InsDownloadParams): Boolean;
 end;

 TnsDownloaderGUIService = class(Tl3ProtoObject, InsDownloaderGUIService)
 private
  FAlien: InsDownloaderGUIService;
 protected
  procedure Cleanup; override;
  function EditParams(const AParams: InsDownloadParams): Boolean;
 public
  class function Instance: InsDownloaderGUIService;
 end;

implementation
uses
 SysUtils,
 l3Base,
 nsOpenOrSaveInternetFileDialog;

var
 g_TnsDownloaderGUIServiceInstance: TnsDownloaderGUIService = nil;

procedure TnsDownloaderGUIService.Cleanup; 
begin
 FAlien := nil;
 inherited;
end;

function TnsDownloaderGUIService.EditParams(const AParams: InsDownloadParams): Boolean;
begin
 if (FAlien <> nil) then
  Result := FAlien.EditParams(AParams)
 else
  Result := TnsOpenOrSaveInternetFileDialog.ChooseParams(AParams);
end;

procedure TnsDownloaderGUIServiceInstance_Free;
begin
 FreeAndNil(g_TnsDownloaderGUIServiceInstance);
end;

class function TnsDownloaderGUIService.Instance: InsDownloaderGUIService;
begin
 if (g_TnsDownloaderGUIServiceInstance = nil) then
 begin
  g_TnsDownloaderGUIServiceInstance := Create;
  l3System.AddExitProc(TnsDownloaderGUIServiceInstance_Free);
 end;
 Result := g_TnsDownloaderGUIServiceInstance;
end;


end.
 