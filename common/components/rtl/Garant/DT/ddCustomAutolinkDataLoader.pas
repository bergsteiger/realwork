unit ddCustomAutolinkDataLoader;

{ $Id: ddCustomAutolinkDataLoader.pas,v 1.3 2016/07/18 10:49:49 fireton Exp $ }

interface

uses
  l3InterfaceList, l3LongintList, l3String, l3StringList, l3ProtoObject,
  m4DictScanner,
  dt_Types,
  ddCSV, ddBaseAutoLinkDataSource;

type
 TddCustomAutolinkDataLoader = class(TddSectionedCSVLoader)
 protected
  f_CodexData: Tl3InterfaceList;
  f_LoneTypesList: Tl3LongintList;
  procedure DispatchSection; override;
  procedure LoadCodexes; virtual; abstract;
  procedure LoadFedLaws; virtual; abstract;
  procedure LoadLoneTypes; virtual; abstract;
  procedure LoadTypeSyns; virtual; abstract;
 public
  constructor Create(const aFileName: string; aCodexData: Tl3InterfaceList; aLoneTypeList: Tl3LongintList);
 end;

const
 cDummyID = 1234567;

implementation

uses
  SysUtils,

  l3Types,
  l3Interfaces,
  l3Base,

  DT_Const;

constructor TddCustomAutolinkDataLoader.Create(const aFileName: string; aCodexData: Tl3InterfaceList;
    aLoneTypeList: Tl3LongintList);
begin
 inherited Create(aFileName, True);
 f_CodexData := aCodexData;
 f_LoneTypesList := aLoneTypeList;
end;

procedure TddCustomAutolinkDataLoader.DispatchSection;
begin
 if l3Same(SectName, 'codex', True) then
  LoadCodexes
 else
 if l3Same(SectName, 'fedlaws', True) then
  LoadFedLaws
 else
 if l3Same(SectName, 'lonetypes', True) then
  LoadLoneTypes
 else
 if l3Same(SectName, 'typesynonyms', True) then
  LoadTypeSyns
 else
  SkipSection;
end;

end.
