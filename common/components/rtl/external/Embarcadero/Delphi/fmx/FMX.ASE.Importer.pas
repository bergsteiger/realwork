{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.ASE.Importer;

interface

uses
  System.Classes, System.SysUtils, FMX.Types3D, FMX.Import, FMX.Objects3D;

type
  TASEModelImporter = class(TModelImporter)
  public
    function GetDescription: string; override;
    function GetExt: string; override;

    function LoadFromFile(const AFileName: string;
      out AMesh: TMeshDynArray; const AOwner: TComponent): boolean; override;
  end;

implementation

uses
  FMX.ASE.Model;

{ TASEModelImporter }

function TASEModelImporter.GetDescription: string;
begin
  Result := 'ASCII Scene Exporter';
end;

function TASEModelImporter.GetExt: string;
begin
  Result := 'ASE';
end;

function TASEModelImporter.LoadFromFile(const AFileName: string;
  out AMesh: TMeshDynArray; const AOwner: TComponent): Boolean;
var
  i, j, idx : Integer;
  LASEMesh : TASEMesh;
  LASEModel : TASEModel;
  LMaterials: TGEMaterials;
  LMaterial: TAseMaterial;
begin
  LASEModel := TASEModel.Create();
  LASEModel.LoadFromFile(AFileName);
  LMaterials := TGEMaterials.Create(False);

  for i := 0 to LASEModel.Materials.Count - 1 do
  begin
     LMaterial := TAseMaterial(LASEModel.Materials[i]);
     LMaterials.Add(LMaterial);
     for j := 0 to LMaterial.SubMaterials.Count - 1 do
       LMaterials.Add(LMaterial.SubMaterials[j]);
  end;

  LMaterials.LoadImages(ExtractFilePath(AFileName));

  AMesh := nil;
  idx := 0;

  for i := 0 to High(LASEModel.Meshes) do
  begin
    LASEMesh := LASEModel.Meshes[i];
    SetLength(AMesh, Length(AMesh) + Length(LASEMesh.FSubMeshes));
    for j := 0 to High(LASEMesh.FSubMeshes) do
    begin
      AMesh[idx] := LASEMesh.FSubMeshes[j].CreateMesh(AOwner, IdentityMatrix3D,
        LMaterials.Materials);
      Inc(idx);
    end;
  end;

  LMaterials.Free;
  LASEModel.Free;

  Result := True;
end;

var
  ASEImporterId: Integer;

initialization
  ASEImporterId := TModelImportServices.RegisterImporter(TASEModelImporter.Create);

finalization
  TModelImportServices.UnregisterImporter(ASEImporterId);

end.
