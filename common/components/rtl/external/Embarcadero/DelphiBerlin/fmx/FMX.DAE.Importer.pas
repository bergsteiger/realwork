{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.DAE.Importer;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, FMX.Import, FMX.DAE.Schema, FMX.Objects3D;

type
  TDAEModelImporter = class(TModelImporter)
  public
    function GetDescription: string; override;
    function GetExt: string; override;

    function LoadFromFile(const AFileName: string;
      out AMesh: TMeshDynArray; const AOwner: TComponent): boolean; override;
  end;

implementation

uses
  System.Math.Vectors, FMX.DAE.Model;

{ TDAEModelImporter }

function TDAEModelImporter.GetDescription: string;
begin
  Result := 'Collada';
end;

function TDAEModelImporter.GetExt: string;
begin
  Result := 'DAE';
end;

function TDAEModelImporter.LoadFromFile(const AFileName: string;
  out AMesh: TMeshDynArray; const AOwner: TComponent): Boolean;
var
  LDAEModel : TDAEModel;
  LNode: TDAEVisualNode;
  idx: Integer;
  rendered: Integer;

  procedure AddMesh(const ADAEMesh: TDAEMesh; const ANode: TDAEVisualNode; const AMatrix: TMatrix3D);
  var
    i: Integer;
  begin
    SetLength(AMesh, Length(AMesh) + Length(ADAEMesh.SubMeshes));
    for i := 0 to High(ADAEMesh.SubMeshes) do
    begin
      AMesh[idx] := ADAEMesh.SubMeshes[i].CreateMesh(AOwner, AMatrix, TDAEModel(ANode.Owner).Materials.Materials);
      Inc(idx);
    end;
    Inc(rendered);
  end;

  procedure AddNode(const ANode: TDAEVisualNode; const AMatrix: TMatrix3D);
  var
    m: Integer;
    LTransformation: TMatrix3D;
  begin

    LTransformation := ANode.Transformation * AMatrix;

    for m := 0 to High(ANode.Mesh) do
      AddMesh(ANode.Mesh[m], ANode, LTransformation);

    for m := 0 to High(ANode.Controllers) do
      AddMesh(ANode.Controllers[m].Mesh, ANode, LTransformation);

    for m := 0 to High(ANode.Children) do
      AddNode(ANode.Children[m], LTransformation);
  end;

begin
  idx := 0;
  AMesh := nil;

  LDAEModel := TDAEModel.Create;
  LDAEModel.LoadFromFile(AFileName);

  rendered := 0;
  for LNode in LDAEModel.SceneList[0].Nodes do
    AddNode(LNode,TMatrix3D.Identity);

  LDAEModel.Free;
  result := true;
end;

var
  DAEImporterId: Integer;

initialization
  DAEImporterId := TModelImportServices.RegisterImporter(TDAEModelImporter.Create);

finalization
  TModelImportServices.UnregisterImporter(DAEImporterId);

end.
