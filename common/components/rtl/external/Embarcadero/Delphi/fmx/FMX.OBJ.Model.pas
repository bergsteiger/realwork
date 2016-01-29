{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.OBJ.Model;

interface

uses
  System.SysUtils, System.Classes, System.Types, FMX.Types3D, FMX.Types,
  FMX.Objects3D, System.Math, FMX.Import, System.UITypes;

type
  TOBJMesh = class
  private
    FName: String;
    FSubMeshes: TGEMeshDynArray;
    function ReadUseMaterial(const ALine: String; const AVertexSource: TGEVertexSource): TGEMesh;
  public
    constructor Create();
    destructor Destroy(); override;
    property SubMeshes: TGEMeshDynArray read FSubMeshes;
  end;

  TOBJMeshDynArray = array of TOBJMesh;

  TOBJModel = class(TCustomModel)
  private
    FMaterials: TGEMaterials;
    FMeshes: TOBJMeshDynArray;
    FVertexSource: TGEVertexSource;
    FSmoothGroup: Integer;
    function ReadMaterials(const ALine: String): String;
    procedure ReadSources(const ALine: String);
    function ReadGeometry(const ALine: String):TOBJMesh;
    procedure ReadSmoothGroup(const ALine: String);
    procedure ReadFaces(const AMesh: TGEMesh; const ALine: String);
  public
    property Materials: TGEMaterials read FMaterials;
    property Meshes: TOBJMeshDynArray read FMeshes;

    procedure LoadFromFile(const AFileName: String);  override;

    constructor Create();
    destructor Destroy(); override;
  end;


implementation

constructor TOBJMesh.Create();
begin
  FSubMeshes := nil;
end;

constructor TOBJModel.Create();
begin
  FVertexSource := TGEVertexSource.Create;
  FMaterials := TGEMaterials.Create(True);
end;

destructor TOBJModel.Destroy();
var
  i : Integer;
begin
  FVertexSource.Free;
  for i := 0 to High(FMeshes) do
    FMeshes[i].Free;

  FMaterials.Free;
end;

destructor TOBJMesh.Destroy();
var
  i : Integer;
begin
  inherited Destroy;
  for i := 0 to High(FSubMeshes) do
    FSubMeshes[i].Free;
end;

procedure TOBJModel.ReadFaces(const AMesh: TGEMesh; const ALine: string);
var
  LVid, LVal, i: Integer;
  LVert: array of array of string;
  LVertex: TGEVertexID;
  LPolygon: TGEPoligonID;
  LSpace: Boolean;
  Ind: Integer;
  Ch: Char;

  procedure AddLetter;
  begin
    if LSpace = true then
    begin
      Inc(LVid);
      SetLength(LVert, LVid + 1);
      SetLength(LVert[LVid], 3);
      LVal := 0;
      LVert[LVid][0] := '0';
      LVert[LVid][1] := '0';
      LVert[LVid][2] := '0';
      LSpace := False;
    end;
  end;

begin
  LVid := -1;
  LVal := 0;
  LVert := nil;
  LSpace := True;
  // parse line like 'f 1/1/1 2/2/1 3/3/1'

  Ind := 0;
  while (Ind < ALine.Length) and (ALine.Chars[Ind] <> #0) do
  begin
    Ch := ALine.Chars[Ind];
    case Ch of
      '0'..'9':
         begin
           AddLetter;
           LVert[LVid][LVal] := LVert[LVid][LVal] + Ch;
         end;
      '/':
         begin
           AddLetter;
           Inc(LVal);
         end;
      ' ', 'f':
         LSpace := True;
    end;
    Inc(Ind);
  end;

  // copy from LVert to LPolygon
  SetLength(LPolygon, LVid + 1);
  for i := 0 to LVid do
  begin
    LVertex.SmoothGroup := FSmoothGroup;
    LVertex.Position := StrToInt(LVert[i][0]) - 1;
    LVertex.Texture0 := StrToInt(LVert[i][1]) - 1;
    LVertex.Normal := StrToInt(LVert[i][2]) - 1;

    LPolygon[i] := LVertex;
  end;
  AMesh.AddPoligon(LPolygon);
end;

function TOBJMesh.ReadUseMaterial(const ALine: string; const AVertexSource: TGEVertexSource): TGEMesh;
var
  LName: String;
  i: Integer;
begin
                                       
  LName := Trim(ALine.Substring('usemtl'.Length));

  for i := 0 to High(FSubMeshes) do
  begin
    Result := FSubMeshes[i];
    if SameText(result.MaterialName, LName) then
       Exit;
  end;
  Result := TGEMesh.Create(AVertexSource);
  Result.MaterialName := LName;
  SetLength(FSubMeshes, Length(FSubMeshes) + 1 );
  FSubMeshes[High(FSubMeshes)] := Result;
end;

function TOBJModel.ReadMaterials(const ALine: String): String;
var
  LName: TStringDynArray;
begin
  LName := StringsToStringDynArray(ALine);
  if not SameText(LName[0], 'mtllib') then Exit;
  Result := LName[1];
end;

procedure TOBJModel.ReadSmoothGroup(const ALine: String);
var
  sgroup: string;
begin
  sgroup := ALine.Substring(2).Trim;
  if sgroup <> 'off' then
    FSmoothGroup := StrToInt(sgroup);
end;

procedure TOBJModel.ReadSources(const ALine: String);
var
  LSource: string;
begin
  LSource := ALine.Substring(2).Trim;
  case ALine.Chars[1] of
    ' ' : FVertexSource.AddPositionSource(FloatStringsToSingleDynArray(LSource));
    'n' : FVertexSource.AddNormalSource(FloatStringsToSingleDynArray(LSource));
    't' : FVertexSource.AddTextue0Source(FloatStringsToSingleDynArray(LSource));
  end;
end;

function TOBJModel.ReadGeometry(const ALine: String) : TOBJMesh;
var
  LName: string;
  i: Integer;
begin
                                       
  LName := ALine.Substring(1).Trim;

  for i := 0 to High(FMeshes) do
  begin
    result := FMeshes[i];
    if SameText(Result.FName, LName) then
      Exit;
  end;
  Result := TOBJMesh.Create();
  Result.FName := LName;

  SetLength(FMeshes, Length(FMeshes) + 1 );
  FMeshes[High(FMeshes)] := Result;
end;

function GetFormatColor(const ax,ay,az: string):TVector3D;
var
  LFormatSettings: TFormatSettings;
begin
  LFormatSettings := TFormatSettings.Create;
  LFormatSettings.DecimalSeparator := '.';

  if (ax + ay + az).Contains(',') then
    LFormatSettings.DecimalSeparator := ',';

  Result := Vector3D(
    StrToFloat(ax, LFormatSettings),
    StrToFloat(ay, LFormatSettings),
    StrToFloat(az, LFormatSettings));
end;

procedure TOBJModel.LoadFromFile(const AFileName: String);
var
  LPos: Integer;
  LFile : TextFile;
  LLine : string;
  LMesh: TOBJMesh;
  LSubMesh: TGEMesh;
  LName: TStringDynArray;
  LMaterial: TGEMaterial;
  LMaterialsFile: string;
begin
  AssignFile(LFile, AFileName);
  Reset(LFile);
  LSubMesh := nil;
  LMesh := nil;
  FSmoothGroup := 0;
  while not EOF(LFile) do
  begin
    Readln(LFile, LLine);
    if (LLine <> '') and (LLine.Chars[0] <> '#') then
    begin
      case LLine.Chars[0] of
        'm' : LMaterialsFile := ReadMaterials(LLine);
        'v' : ReadSources(LLine);
        'g' : LMesh := ReadGeometry(LLine);
        'u' :
          begin
            if LMesh = nil then
              LMesh := ReadGeometry('g default');
            LSubMesh := LMesh.ReadUseMaterial(LLine, FVertexSource);
          end;
        's' : ReadSmoothGroup(LLine);
        'f' :
          begin
           if (LMesh = nil) then
              LMesh := ReadGeometry('g default');

           if (LSubMesh = nil) then
               LSubMesh := LMesh.ReadUseMaterial('usemtl Default', FVertexSource);
             ReadFaces(LSubMesh, LLine.Trim);
          end;
      end;
    end;
  end;

  if not FileExists(LMaterialsFile) then
     LMaterialsFile := ChangeFileExt(AFileName, '.mtl');

 // load material file
  if FileExists(LMaterialsFile) then
  begin
    AssignFile(LFile, LMaterialsFile);
    Reset(LFile);
    LMaterial := nil;
    while not EOF(LFile) do
    begin
      Readln(LFile, LLine);

      if (LLine <> '') and (LLine.Chars[0] <> '#') then
      begin
        LName := StringsToStringDynArray(LLine);
        if SameText(LName[0], 'newmtl') then
        begin
          LMaterial := FMaterials.Add(TGEMaterial.Create);
          LMaterial.FName := LName[1];
        end else
        if (Assigned(LMaterial)) then
        begin

          if SameText(LName[0], 'map_Kd') then
          begin
            LPos := LLine.IndexOf('map_Kd') + 'map_Kd'.Length;
            LMaterial.FDiffuseMap := LLine.Substring(LPos + 1, LLine.Length - LPos);
          end
          else if SameText(LName[0], 'Ka') then
            LMaterial.FAmbient := GetFormatColor(LName[1], LName[2], LName[3])
          else if SameText(LName[0], 'Ks') then
            LMaterial.FSpecular  := GetFormatColor(LName[1], LName[2], LName[3])
          else if SameText(LName[0], 'Kd') then
            LMaterial.FDiffuse  := GetFormatColor(LName[1], LName[2], LName[3])
        end;
      end;
    end;
    Closefile(LFile);
  end;

end;

end.
