unit nsValueMaps;
{* Мапы для UI-строка <=> что-то }

{$Include nsDefine.inc }

interface

uses
  L10nInterfaces
  ;

function nsIntegerMapManager: InsIntegerValueMapManager;

function nsStringMapManager: InsStringValueMapManager;

implementation

uses
  afwValueMaps,
  nsIntegerValueMapFactory,
  nsStringValueMapFactory
  ;

var
 g_IntegerFactory: InsIntegerValueMapFactory = nil;
 g_StringFactory: InsStringValueMapFactory = nil;

function nsIntegerMapManager: InsIntegerValueMapManager;
begin
 Result := afwIntegerMapManager;
 if g_IntegerFactory = nil then
 begin
  g_IntegerFactory := TnsIntegerValueMapFactory.Make;
  Result.RegisterFactory(g_IntegerFactory, True);
 end;
end;

function nsStringMapManager: InsStringValueMapManager;
begin
 Result := afwStringMapManager;
 if g_StringFactory = nil then
 begin
  g_StringFactory := TnsStringValueMapFactory.Make;
  Result.RegisterFactory(g_StringFactory, True);
 end;
end;

initialization

finalization
 afwIntegerMapManager.UnregisterFactory(g_IntegerFactory);
 afwStringMapManager.UnregisterFactory(g_StringFactory);
 g_IntegerFactory := nil;
 g_StringFactory := nil;



end.

