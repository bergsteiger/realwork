{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.DAE.Model;

interface

uses
  System.SysUtils, System.Classes, System.Types, FMX.Types3D, FMX.Types,
  FMX.Objects3D,  FMX.DAE.Schema, System.Math, FMX.Import, XML.XMLIntf;

type
  PDAEVertexSource = ^TDAEVertexSource;
  TDAEVertexSource = record
    Id: string;
    Data: TSingleDynArray;
    Stride: Integer;
  end;

  TDAESurface = record
    FID: string;
    FSource: string;
  end;
  TDAESurfaceArray = array of TDAESurface;

  TDAEExporter = (de3DStudioMax, deMaya, deUnknown);
  TDAEVertexSourceDynArray = array of TDAEVertexSource;

  TGEPhongMapMode  = (pmEmission, pmAmbient, pmDiffuse, pmSpecular,
    pmShininess, pmReflective, pmReflectivity, pmTransparent, mpTransparency);

  TGEMap = record
    Image: TGEImage;
    Color: TVector3D;
  end;

  TGEEffect = class
  public
    FId: string;
    FMaps: array [TGEPhongMapMode] of TGEMap;
  end;

  TSourceMode = (smVertex, smNormal, smTexCoord);

  TSourceSemantic = record
    FSource: PDAEVertexSource;
    FOffset: Integer;
  end;

  TSourceSemantics = array [TSourceMode] of TSourceSemantic;

  TDAEVertices  = record
    Id: string;
    Sources : TSourceSemantics;
  end;

  TSourceSemanticDynArray = array of TSourceSemantic;
  TSourceSemanticList = array [TSourceMode] of TSourceSemantic;

  TDAEMesh = class
  private
    FId : string;
    FSubMeshes: TGEMeshDynArray;
  public
    property Id : string read FId;
    destructor Destroy(); override;
    property SubMeshes: TGEMeshDynArray read FSubMeshes;
  end;

  TDAEController = class
  private
    FId : string;
    FMesh: TDAEMesh;
  public
    property Id : string read FId;
    property Mesh: TDAEMesh read FMesh;
  end;

  TDAEMeshDynArray = array of TDAEMesh;
  TDAEControllerDynArray = array of TDAEController;

  TDAEVisualNode = class;
  TDAEVisualNodeDynArray = array of TDAEVisualNode;
  TDAEVisualNode = class
  private
    FTransformation: TMatrix3D;
    FMesh : TDAEMeshDynArray;
    FControllers : TDAEControllerDynArray;
    FChildren: TDAEVisualNodeDynArray;
    FId : string;
    FNodeUrls: array of string;
    FOwner: TObject;
  public
    property Transformation: TMatrix3D read FTransformation;
    property Mesh: TDAEMeshDynArray read FMesh;
    property Controllers : TDAEControllerDynArray read FControllers;
    property Owner : TObject read FOwner;

    property Children: TDAEVisualNodeDynArray read FChildren;
    property Id: string read FId;
    destructor Destroy; override;
  end;

  TDAEVisualScene = class
  private
    FNodes: TDAEVisualNodeDynArray;
  public
    property Nodes: TDAEVisualNodeDynArray read FNodes;
  end;

  TDAEVisualSceneDynArray = array of TDAEVisualScene;

  TDAEModel = class(TCustomModel)
  private
    FExporter: TDAEExporter;
    FFileName: string;
    FImageList: array of TGEImage;
    FMeshes: TDAEMeshDynArray;
    FControllers: TDAEControllerDynArray;
    FMaterials: TGEMaterials;
    FEffects: array of TGEEffect;

    FModels: array of TDAEModel;

    FAllNodes: TDAEVisualNodeDynArray;
    FSceneList: TDAEVisualSceneDynArray;
    function GetVertexSource(const AVertex, ASemantics: TSourceSemantics):TGEVertexSource;
    function LoadPolygons(
      const ASubMesh: IXMLPolygons_type;
      const AVertex: TSourceSemantics;
      const ASources: TDAEVertexSourceDynArray): TGEMesh;
    function LoadTriangles(
      const ASubMesh: IXMLTriangles_type;
      const AVertex: TSourceSemantics;
      const ASources: TDAEVertexSourceDynArray): TGEMesh;
    function LoadPolylist(
      const ASubMesh: IXMLPolylist_type;
      const AVertex: TSourceSemantics;
      const ASources: TDAEVertexSourceDynArray): TGEMesh;

    function FindEffectById(const AName:string): TGEEffect;
    function FindImageById(const AName:string): TGEImage;
    function FindMeshById(const AName:string): TDAEMesh;
    function FindNodeById(const AName:string): TDAEVisualNode;
    function FindControllerById(const AName:string): TDAEController;

    function GetMesh(const AGeometry: IXMLGeometry_type): TDAEMesh;  overload;
    function GetImage(const AImage: IXMLImage_type): TGEImage;
    function GetMaterial(const AMaterial: IXMLMaterial_type): TGEMaterial;
    function GetEffect(const AEffect: IXMLEffect_type): TGEEffect;
    function GetScene(const AScene: IXMLVisual_scene_type): TDAEVisualScene;
    function GetNode(const ANode: IXMLNode_type): TDAEVisualNode;
    function GetController(const AController: IXMLController_type): TDAEController;

    procedure AddNode(const ANode: TDAEVisualNode);
    procedure FindNodeUrls();

    procedure ImportFromGeometryLib(const AGeometryLib: IXMLLibrary_geometries_type);
    procedure ImportFromImageLib(const AImageLib: IXMLLibrary_images_type);
    procedure ImportFromMaterialLib(const AMaterialLib: IXMLLibrary_materials_type);
    procedure ImportFromEffectLib(const AEffectLib: IXMLLibrary_effects_type);
    procedure ImportFromSceneLib(const ASceneLib: IXMLLibrary_visual_scenes_type);
    procedure ImportFromNodeLib(const ANodesLib: IXMLLibrary_nodes_type);
    procedure ImportExporter(const AAssetLib: IXMLAsset_type);
    procedure ImportFromControllersLib(const AControlerLib: IXMLLibrary_controllers_type);
    procedure ImportFromCot(var AMap: TGEMap; const AMapCot: IXMLFx_common_color_or_texture_type;
     const ASurfaces: TDAESurfaceArray);

  public
    property SceneList: TDAEVisualSceneDynArray read FSceneList;
    property Materials: TGEMaterials read FMaterials;
    property Meshes: TDAEMeshDynArray read FMeshes;

    procedure LoadFromFile(const AFileName: string); override;
    constructor Create;
    destructor Destroy; override;
  end;

  EDAEError = class(Exception);

implementation

uses
  FMX.Consts;

procedure TDAEModel.LoadFromFile(const AFileName: string);
var
  LCollada: IXMLCOLLADA;
begin
  FFileName := AFileName;
  LCollada := LoadCOLLADA(AFileName);

  ImportExporter(LCollada.Asset);

  if (LCollada.Library_images.Count > 0) then
     ImportFromImageLib(LCollada.Library_images[0]);

  if (LCollada.Library_effects.Count > 0) then
     ImportFromEffectLib(LCollada.Library_effects[0]);

  if (LCollada.Library_materials.Count > 0) then
     ImportFromMaterialLib(LCollada.Library_materials[0]);

  if (LCollada.Library_geometries.Count > 0) then
     ImportFromGeometryLib(LCollada.Library_geometries[0]);

  if (LCollada.Library_controllers.Count > 0) then
     ImportFromControllersLib(LCollada.Library_controllers[0]);

  if (LCollada.Library_nodes.Count > 0) then
     ImportFromNodeLib(LCollada.Library_nodes[0]);

  if (LCollada.Library_visual_scenes.Count > 0) then
     ImportFromSceneLib(LCollada.Library_visual_scenes[0]);

  FindNodeUrls();

  Materials.LoadImages(ExtractFilePath(AFileName));
end;


function FindSource(const ASourceName: string; const ASources: TDAEVertexSourceDynArray): PDAEVertexSource;
var
  i: Integer;
begin
  for i := 0 to High(ASources) do
  begin
    if SameText(ASourceName, '#' + ASources[i].Id) or
       SameText(ASourceName, ASources[i].Id) then
    begin
      Result := @ASources[i];
      exit;
    end;
  end;
  Result := nil; // if not found Result POSITION attribute
end;

function GetSemantic(const Input: IXMLInput_local_offset_typeList;
  const ASources: TDAEVertexSourceDynArray): TSourceSemantics;
var
  j: Integer;
  k : TSourceMode;
  res : TSourceSemantic;
begin
  for k := Low(TSourceMode) to High(TSourceMode) do
  begin
    Result[k].FSource := nil;
    Result[k].FOffset := 0;
  end;

  for j := 0 to Input.Count - 1 do
  begin
    res.FOffset := Input[j].Offset;
    res.FSource := FindSource(Input[j].Source, ASources);
    if SameText(Input[j].Semantic, 'VERTEX') then
      Result[smVertex] := res
    else if SameText(Input[j].Semantic, 'NORMAL') then
      Result[smNormal] := res
    else if SameText(Input[j].Semantic, 'TEXCOORD') then
      Result[smTexCoord]:= res;
  end;
end;

function GetInputs(const Input: IXMLInput_local_typeList;
  const ASources: TDAEVertexSourceDynArray): TSourceSemantics;
var
  j: Integer;
  k : TSourceMode;
  res : TSourceSemantic;
begin
  for k := Low(TSourceMode) to High(TSourceMode) do
  begin
    Result[k].FSource := nil;
    Result[k].FOffset := 0;
  end;

  for j := 0 to Input.Count - 1 do
  begin
    res.FSource := FindSource(Input[j].Source, ASources);

    if SameText(Input[j].Semantic, 'POSITION') then
      Result[smVertex] := res
    else if SameText(Input[j].Semantic, 'NORMAL') then
      Result[smNormal] := res
    else if SameText(Input[j].Semantic, 'TEXCOORD') then
      Result[smTexCoord]:= res;
  end;
end;

destructor TDAEMesh.Destroy();
var
  i : Integer;
begin
  inherited Destroy;
  for i := 0 to High(FSubMeshes) do
    FSubMeshes[i].Free;
end;

function TDAEModel.GetVertexSource(const AVertex, ASemantics: TSourceSemantics):TGEVertexSource;
var
  k : TSourceMode;
begin
  result := TGEVertexSource.Create;
  for k := Low(TSourceMode) to High(TSourceMode) do
  begin
    if Assigned(AVertex[k].FSource) then
    case k of
        smVertex:
          result.SetPositionSource(AVertex[k].FSource.Data);
        smTexCoord:
          result.SetTextue0Source(AVertex[k].FSource.Data, AVertex[k].FSource.Stride);
        smNormal:
          result.SetNormalSource(AVertex[k].FSource.Data);

    end else
    if Assigned(ASemantics[k].FSource) then
    case k of
      smVertex:
        result.SetPositionSource(ASemantics[k].FSource.Data);
      smTexCoord:
        result.SetTextue0Source(ASemantics[k].FSource.Data, ASemantics[k].FSource.Stride);
      smNormal:
        result.SetNormalSource(ASemantics[k].FSource.Data);
    end;
  end;
end;

procedure TDAEModel.ImportExporter(const AAssetLib: IXMLAsset_type);
var
  LTool: string;
begin
  if AAssetLib.Contributor.Count > 0 then
  begin
    LTool := AAssetLib.Contributor[0].Authoring_tool;

    FExporter := deUnknown;
    if LTool.Contains('Maya') then
      FExporter := deMaya
    else
    if LTool.Contains('Max') then
      FExporter := de3DStudioMax;
  end;
end;

procedure SetVertexId(var AVertex:TGEVertexID; const AMode: TSourceMode; const Aid: Integer);
begin
  case AMode of
   smVertex:
     AVertex.Position := Aid;
   smTexCoord:
     AVertex.Texture0 := Aid;
   smNormal:
     AVertex.Normal := Aid;
  end;
end;

function TDAEModel.LoadPolygons(
  const ASubMesh: IXMLPolygons_type;
  const AVertex: TSourceSemantics;
  const ASources: TDAEVertexSourceDynArray): TGEMesh;
var
  j, l, i: Integer;
  k: TSourceMode;
  LPolygon: TIntegerDynArray;
  LSemantics: TSourceSemantics;

  LTriangle: TGetriangleID;
  LVertexSource: TGEVertexSource;
begin
  LSemantics := GetSemantic(ASubMesh.Input, ASources);
  LVertexSource := GetVertexSource(AVertex, LSemantics);
  result := TGEMesh.Create(LVertexSource);
  result.MaterialName := ASubMesh.Material;

  for j := 0 to ASubMesh.P.Count - 1 do
  begin
    LPolygon := IntStringsToIntegerDynArray(ASubMesh.P[j].GetText);
    for k := Low(TSourceMode) to High(TSourceMode) do
    begin
      for l := 0 to 2 do
      begin
        i := LPolygon[LSemantics[k].FOffset + l * 3];

        if Assigned(AVertex[k].FSource) then
           SetVertexId(LTriangle[l], k, i);
        if Assigned(LSemantics[k].FSource) then
           SetVertexId(LTriangle[l], k, i);
      end;
    end;
    result.AddTriangle(LTriangle);
  end;
  LVertexSource.Free;
end;

function TDAEModel.LoadPolylist(const ASubMesh: IXMLPolylist_type;
  const AVertex: TSourceSemantics;
  const ASources: TDAEVertexSourceDynArray): TGEMesh;
var
  i, k, LJump, LNumSemantic, LNumPolygon, LPolygonNo: Integer;
  l: TSourceMode;
  LPolygon: TIntegerDynArray;
  LSemantics: TSourceSemantics;
  LVertexSource: TGEVertexSource;
  LPoligon: TGePoligonID;
  LVCount: TIntegerDynArray;
begin
  LSemantics := GetSemantic(ASubMesh.Input, ASources);
  LVertexSource := GetVertexSource(AVertex, LSemantics);

  Result := TGEMesh.Create(LVertexSource);
  Result.MaterialName := ASubMesh.Material;

  LVCount:= IntStringsToIntegerDynArray(ASubMesh.VCount);
  LPolygon := IntStringsToIntegerDynArray(ASubMesh.P.GetText);
  LJump := 0;

  LNumPolygon:= ASubMesh.Count;
  LNumSemantic := ASubMesh.Input.Count;
  for LPolygonNo := 0 to LNumPolygon - 1 do
  begin
    SetLength(LPoligon, LVCount[LPolygonNo]);
    for k := 0 to LVCount[LPolygonNo] - 1 do
    begin
      LPoligon[k] := NullVertexID;
      for l := Low(LSemantics) to High(LSemantics) do
      begin
        i := LPolygon[LJump + k * LNumSemantic + LSemantics[l].FOffset];
        if Assigned(AVertex[l].FSource) then
          SetVertexId(LPoligon[k], l, i);

        if Assigned(LSemantics[l].FSource) then
           SetVertexId(LPoligon[k], l, i);
      end;
    end;
    LJump:= LVCount[LPolygonNo] * LNumSemantic;
    Result.AddPoligon(LPoligon);
  end;
  LVertexSource.Free;
end;

function TDAEModel.LoadTriangles(
  const ASubMesh: IXMLTriangles_type;
  const AVertex: TSourceSemantics;
  const ASources: TDAEVertexSourceDynArray): TGEMesh;
var
  i, l, LJump, LNumSemantic: Integer;
  k: TSourceMode;
  LPolygon: TIntegerDynArray;
  LSemantics: TSourceSemantics;
  LTriangle: TGetriangleID;
  LVertexSource: TGEVertexSource;
begin
  LSemantics := GetSemantic(ASubMesh.Input, ASources);
  LVertexSource := GetVertexSource(AVertex, LSemantics);

  Result := TGEMesh.Create(LVertexSource);
  Result.MaterialName := ASubMesh.Material;

  LPolygon := IntStringsToIntegerDynArray(ASubMesh.P.GetText);
  LJump := 0;

  LNumSemantic := ASubMesh.Input.Count;
  while (LJump < Length(LPolygon)) do
  begin
    LTriangle[0] := NullVertexID;
    LTriangle[1] := NullVertexID;
    LTriangle[2] := NullVertexID;

    for k := Low(TSourceMode) to High(TSourceMode) do
    begin
      for l := 0 to 2 do
      begin
        i := LPolygon[LJump + l * LNumSemantic + LSemantics[k].FOffset];
        if Assigned(AVertex[k].FSource) then
          SetVertexId(LTriangle[l], k, i);

        if Assigned(LSemantics[k].FSource) then
           SetVertexId(LTriangle[l], k, i);
      end;
    end;

    Inc(LJump, LNumSemantic * 3);
    Result.AddTriangle(LTriangle);
  end;
  LVertexSource.Free;
end;

function TDAEModel.GetMesh(const AGeometry: IXMLGeometry_type): TDAEMesh;
var
  i : Integer;
  LSource: IXMLSource_type;
  LSources: TDAEVertexSourceDynArray;
  LMesh: TDAEMesh;
  MeshType: IXMLMesh_type;
  LVertices: TSourceSemantics;
begin
  MeshType := AGeometry.Mesh;
  LMesh := TDAEMesh.Create;
  LMesh.FId := AGeometry.Id;

  SetLength(LSources, MeshType.Source.Count);
  for i := 0 to MeshType.Source.Count - 1 do
  begin
    LSource := MeshType.Source[i];
    LSources[i].Id := LSource.Id;
    LSources[i].Stride := LSource.Technique_common.Accessor.Stride;
    LSources[i].Data := FloatStringsToSingleDynArray(LSource.Float_array.Text);
  end;

  LVertices := GetInputs(MeshType.Vertices.Input, LSources);

  if (MeshType.Polygons.Count > 0) then
  begin
    SetLength(LMesh.FSubMeshes, MeshType.Polygons.Count);
    for i := 0 to MeshType.Polygons.Count - 1 do
      LMesh.FSubMeshes[i] := LoadPolygons(MeshType.Polygons.Items[i], LVertices, LSources);
  end
  else
  begin
    if (MeshType.Triangles.Count > 0) then
    begin
      SetLength(LMesh.FSubMeshes, MeshType.Triangles.Count);
      for i := 0 to MeshType.Triangles.Count - 1 do
      begin
        LMesh.FSubMeshes[i] := LoadTriangles(MeshType.Triangles.Items[i], LVertices, LSources);
      end
    end
    else
      if (MeshType.Polylist.Count > 0) then
      begin
        SetLength(LMesh.FSubMeshes, MeshType.Polylist.Count);
        for i := 0 to MeshType.Polylist.Count - 1 do
        begin
          LMesh.FSubMeshes[i] := LoadPolylist(MeshType.Polylist.Items[i], LVertices, LSources);
        end;
      end;
  end;
    // else
  //  raise EDAEError.CreateRes(@SIndexDataNotFoundError);

  Result := LMesh;
end;

function TDAEModel.FindEffectById(const AName:string): TGEEffect;
var
  i: Integer;
begin
  for i := 0 to High(FEffects) do
  begin
    Result := FEffects[i];
    if SameText(Result.FId, AName) then
      Exit;
  end;
  raise EDAEError.CreateResFmt(@SEffectIdNotFoundError, [AName]);
end;

function TDAEModel.FindMeshById(const AName:string): TDAEMesh;
var
  i: Integer;
begin
  for i := 0 to High(FMeshes) do
  begin
    Result := FMeshes[i];
    if SameText('#' + Result.FId, AName) or SameText(Result.FId, AName) then
      Exit;
  end;
  raise EDAEError.CreateResFmt(@SMeshIdNotFoundError, [AName]);
end;

function TDAEModel.FindNodeById(const AName:string): TDAEVisualNode;
var
  i, LPos, LLength: Integer;
  LFileName: string;
  LNodeName: string;
  LModel : TDAEModel;
begin
  for i := 0 to High(FAllNodes) do
  begin
    Result := FAllNodes[i];
    if SameText('#' + Result.FId, AName) or SameText(Result.FId, AName) then
      exit;
  end;

  LPos := AName.IndexOf('.dae#');
  if LPos >= 0 then
  begin
    LFileName := AName.Substring(0, LPos + 4);

    if SetLocalPath(ExtractFilePath(FFileName), LFileName) then
    begin
      LNodeName := AName.Substring(LPos + 4);

      LModel := TDAEModel.Create;
      LModel.LoadFromFile(LFileName);
      result := LModel.FindNodeById(LNodeName);

      LLength := Length(FModels);
      Setlength(FModels, LLength + 1);
      FModels[LLength] := LModel;

      Exit;
    end;
  end;

  raise EDAEError.CreateResFmt(@SMeshIdNotFoundError, [AName]);
end;

function TDAEModel.FindControllerById(const AName:string): TDAEController;
var
  i: Integer;
begin
  for i := 0 to High(FControllers) do
  begin
    Result := FControllers[i];
    if SameText('#' + Result.FId, AName) or SameText(Result.FId, AName) then
      Exit;
  end;
  raise EDAEError.CreateResFmt(@SControllerIdNotFoundError, [AName]);
end;

procedure TDAEModel.ImportFromNodeLib(const ANodesLib: IXMLLibrary_nodes_type);
var
  i : Integer;
begin
  for i := 0 to ANodesLib.Node.Count - 1 do
     GetNode(ANodesLib.Node[i]);
end;

procedure TDAEModel.ImportFromGeometryLib(const AGeometryLib
  : IXMLLibrary_geometries_type);
var
  i: Integer;
begin
  SetLength(FMeshes, AGeometryLib.Geometry.Count);
  for i := 0 to AGeometryLib.Geometry.Count - 1 do
    FMeshes[i] := GetMesh(AGeometryLib.Geometry[i]);
end;

function TDAEModel.GetImage(const AImage: IXMLImage_type): TGEImage;
const
  LFilePred: string = 'file://';
var
  LFileName : string;
  LLen:Integer;
begin
  Result := TGEImage.Create();
  Result.FId := AImage.Id;
  Result.FName := AImage.Name;
  LFileName := AImage.Init_from.Text;

  if LFileName.Contains(LFilePred) then
  begin
    LLen := LFilePred.Length;
    LFileName := LFileName.Substring(LLen , LFileName.Length - LLen);
  end;

  Result.FFileName := LFileName;
end;

procedure TDAEModel.ImportFromImageLib(const AImageLib: IXMLLibrary_images_type);
var
  i: Integer;
begin
  SetLength(FImageList, AImageLib.Image.Count);
  for i := 0 to AImageLib.Image.Count - 1 do
    FImageList[i] := GetImage(AImageLib.Image[i]);
end;

function TDAEModel.GetMaterial(const AMaterial: IXMLMaterial_type): TGEMaterial;
var
 LEffect: TGEEffect;
begin
  Result := TGEMaterial.Create();
  Result.FName := '#' + AMaterial.Id;

  LEffect := FindEffectById(AMaterial.Instance_effect.Url);

  if Assigned(LEffect.FMaps[pmDiffuse].Image) then
    Result.FDiffuseMap := LEffect.FMaps[pmDiffuse].Image.FFileName;

  Result.FAmbient := LEffect.FMaps[pmAmbient].Color;
  Result.FDiffuse := LEffect.FMaps[pmDiffuse].Color;
  Result.FSpecular := LEffect.FMaps[pmSpecular].Color;
end;

procedure TDAEModel.ImportFromMaterialLib(const AMaterialLib: IXMLLibrary_materials_type);
var
  i: Integer;
begin
  FMaterials.Count := AMaterialLib.Material.Count;
  for i := 0 to AMaterialLib.Material.Count - 1 do
    FMaterials[i] := GetMaterial(AMaterialLib.Material[i]);
end;

function TDAEModel.GetController(const AController: IXMLController_type): TDAEController;
begin
  Result := TDAEController.Create;
  Result.FMesh := Self.FindMeshById(AController.Skin.Source);
  Result.FId := AController.Id;
end;

procedure TDAEModel.ImportFromControllersLib(const AControlerLib: IXMLLibrary_controllers_type);
var
  i: Integer;
begin
  SetLength(FControllers, AControlerLib.Controller.Count);
  for i := 0 to AControlerLib.Controller.Count - 1 do
    FControllers[i] := GetController(AControlerLib.Controller[i]);
end;

function TDAEModel.FindImageById(const AName:string): TGEImage;
var
  i: Integer;
begin
  if Length(AName) > 0 then
  for i := 0 to High(FImageList) do
  begin
    Result := FImageList[i];
    if SameText(Result.FId, AName) or SameText(Result.FId + '-sampler', AName) or
      SameText(Result.FName, AName) or SameText(Result.FName + '-sampler', AName) then
      exit;
  end;
  Result := nil;
end;

function GetSurfaceSource(const ANode: IXMLNode):string;
var
  init: IXMLNode;
  i: Integer;
begin
    for i := 0 to ANode.ChildNodes.Count-1 do
    begin
       init := ANode.ChildNodes[i];
       if Sametext('init_from', init.NodeName) then
         Result := init.Text;
    end;
end;

function GetSurfaceSampler2D(const ANode: IXMLNode):string;
var
  init: IXMLNode;
  i: Integer;
begin
    for i := 0 to ANode.ChildNodes.Count-1 do
    begin
       init := ANode.ChildNodes[i];
       if Sametext('source', init.NodeName) then
         Result := init.Text;
    end;
end;

function FindSurface(const AName: string; const ASurfaces: TDAESurfaceArray):string;
var
  i: Integer;
begin
  for i := 0 to High(ASurfaces) do
  begin
    Result := ASurfaces[i].FSource;
    if Sametext(ASurfaces[i].FID, AName) then
      Exit;
  end;
end;

procedure TDAEModel.ImportFromCot(
    var AMap: TGEMap;
  const AMapCot: IXMLFx_common_color_or_texture_type;
  const ASurfaces: TDAESurfaceArray);
var
  LColor: TSingleDynArray;
begin

 if not Assigned(AMap.Image) then
   AMap.Image := FindImageById(FindSurface(AMapCot.Texture.Texture, ASurfaces));

 if not Assigned(AMap.Image) then
     AMap.Image := FindImageById(AMapCot.Texture.Texture);

 if not Assigned(AMap.Image) then
 begin
   LColor := FloatStringsToSingleDynArray(AMapCot.Color.Text);
   if length(LColor) >= 3 then
   begin
     AMap.Color.X := LColor[0];
     AMap.Color.Y := LColor[1];
     AMap.Color.Z := LColor[2];
   end;
 end;
end;

function TDAEModel.GetEffect(const AEffect: IXMLEffect_type): TGEEffect;
var
  LPhong: IXMLProfile_common_type_technique_phong;
  LBlinn: IXMLProfile_common_type_technique_blinn;
  LLambert: IXMLProfile_common_type_technique_lambert;

  i,j:integer;
  node: IXMLNode;
  param: IXMLFx_common_newparam_type;
  surface: TDAESurface;

  samplers: TDAESurfaceArray;
  surfaces: TDAESurfaceArray;
begin
  Result := TGEEffect.Create;
  Result.FId := '#' + AEffect.Id;    // id instance has #

  // new schema is not supporting that
  samplers := nil;
  surfaces := nil;
  for j := 0 to AEffect.Profile_COMMON.Newparam.Count-1 do
  begin
    param := AEffect.Profile_COMMON.Newparam[j];

    for i := 0 to param.ChildNodes.Count-1 do
    begin
      node := param.ChildNodes[i];
      surface.FID := param.Sid;
      if Sametext('surface', node.NodeName) then
      begin
        surface.FSource := GetSurfaceSource(node);
        SetLength(surfaces, Length(surfaces) + 1);
        surfaces[high(surfaces)] := surface;
      end;

      if Sametext('sampler2D', node.NodeName) then
      begin
        surface.FSource := GetSurfaceSampler2D(node);
        SetLength(samplers, Length(samplers) + 1);
        samplers[high(samplers)] := surface;
      end;
    end;
  end;

  for i := 0 to High(samplers) do
    samplers[i].FSource := FindSurface(samplers[i].FSource, surfaces);

  Result.FMaps[pmAmbient].Image := nil;
  Result.FMaps[pmAmbient].Color := Vector3D(1,1,1,1);
  Result.FMaps[pmDiffuse].Image := nil;
  Result.FMaps[pmDiffuse].Color := Vector3D(1,1,1,1);
  Result.FMaps[pmSpecular].Image := nil;
  Result.FMaps[pmSpecular].Color := Vector3D(1,1,1,1);

  if SameText(AEffect.Profile_COMMON.Technique.Sid, 'standard') or
     SameText(AEffect.Profile_COMMON.Technique.Sid, 'phong') or
     SameText(AEffect.Profile_COMMON.Technique.Sid, 'common') or
     SameText(AEffect.Profile_COMMON.Technique.Sid, 'blinn') then
  begin
    Result.FMaps[pmAmbient].Color := Vector3D(0,0,0);

    LLambert := AEffect.Profile_COMMON.Technique.Lambert;
    ImportFromCot(Result.FMaps[pmAmbient], LLambert.Ambient, samplers);
    ImportFromCot(Result.FMaps[pmDiffuse], LLambert.Diffuse, samplers);

    LBlinn := AEffect.Profile_COMMON.Technique.Blinn;
    ImportFromCot(Result.FMaps[pmAmbient], LBlinn.Ambient,samplers);
    ImportFromCot(Result.FMaps[pmDiffuse], LBlinn.Diffuse,samplers);
    ImportFromCot(Result.FMaps[pmSpecular], LBlinn.Specular,samplers);

    LPhong := AEffect.Profile_COMMON.Technique.Phong;
    ImportFromCot(Result.FMaps[pmAmbient], LPhong.Ambient, samplers);
    ImportFromCot(Result.FMaps[pmDiffuse], LPhong.Diffuse, samplers);
    ImportFromCot(Result.FMaps[pmSpecular], LPhong.Specular, samplers);
  end;
end;

procedure ChangeMaterialNames(const AMesh: TDAEMesh;
  const Technique: IXMLBind_material_type_technique_common);
var
  i, j : integer;
  LName, LTarget: string;
begin
  for i := 0 to Technique.Count - 1 do
  begin
    LName := Technique.Instance_material[i].Symbol;
    LTarget := Technique.Instance_material[i].Target;
    for j := 0 to High(AMesh.FSubMeshes) do
      if SameText(AMesh.FSubMeshes[j].MaterialName,LName) then
         AMesh.FSubMeshes[j].MaterialName := LTarget;
  end;
end;

procedure TDAEModel.FindNodeUrls();
var
  ANode: TDAEVisualNode;
  i, j, id: Integer;
begin
  for i := 0 to High(FAllNodes) do
  begin
    ANode := FAllNodes[i];
    id := Length(ANode.Children);
    SetLength(ANode.FChildren , id + Length(ANode.FNodeUrls));
    for j := 0 to High(ANode.FNodeUrls) do
    begin
      ANode.FChildren[id] := FindNodeById(ANode.FNodeUrls[j]);
      inc(id);
    end;
  end;
end;

procedure TDAEModel.AddNode(const ANode: TDAEVisualNode);
var
  LLength: Integer;
begin
  LLength := Length(FAllNodes);
  SetLength(FAllNodes, LLength + 1);
  FAllNodes[LLength] := ANode;
  ANode.FOwner := self;
end;

function TDAEModel.GetNode(const ANode: IXMLNode_type): TDAEVisualNode;
var
  i: Integer;
  LRot: array [0..2] of Single;
  LArr: TSingleDynArray;

  procedure UpdateMatrix(const AMatrix: TMatrix3D);
  begin
     Result.FTransformation := Matrix3DMultiply(AMatrix, Result.FTransformation);
  end;

begin
  Result := TDAEVisualNode.Create;
  AddNode(Result);

  Result.FId := ANode.Id;

  SetLength(Result.FMesh, ANode.Instance_geometry.Count);
  for i := 0 to High(Result.FMesh) do
  begin
    Result.FMesh[i] := FindMeshById(ANode.Instance_geometry[i].Url);
    if Assigned(Result.FMesh[i]) then
      ChangeMaterialNames(Result.FMesh[i],
      ANode.Instance_geometry[i].Bind_material.Technique_common);
  end;

  {checking for child nodes of the current node}
  if ANode.Node.Count > 0 then
  begin
    SetLength(Result.FChildren, ANode.Node.Count);
    for i := 0 to ANode.Node.Count-1 do
      Result.FChildren[i] := GetNode(ANode.Node[i]);
  end
  else
   Result.FChildren := nil;

  SetLength(Result.FControllers, ANode.Instance_controller.Count);
  for i := 0 to High(Result.FControllers) do
  begin
    Result.FControllers[i] := FindControllerById(ANode.Instance_controller[i].Url);
    if Assigned(Result.FControllers[i]) then
      ChangeMaterialNames(Result.FControllers[i].FMesh,
      ANode.Instance_controller[i].Bind_material.Technique_common);
  end;

  SetLength(Result.FNodeUrls, ANode.Instance_node.Count);
  for i := 0 to ANode.Instance_node.Count-1 do
     Result.FNodeUrls[i] := ANode.Instance_node[i].Url;

  Result.FTransformation := IdentityMatrix3D;

  LRot[0] := 0;
  LRot[1] := 0;
  LRot[2] := 0;

  for i := 0 to ANode.Rotate.Count - 1  do
  begin
    LArr := FloatStringsToSingleDynArray(ANode.Rotate[i].Text);
    UpdateMatrix(CreateRotationMatrix3D(Vector3D(LArr[0],LArr[1],LArr[2]),LArr[3]));
  end;

  if ANode.Rotate.Count > 0 then
    UpdateMatrix(CreateRotationMatrix3D(LRot[0],LRot[1],LRot[2]));

  for i := 0 to ANode.Translate.Count - 1 do
  begin
    LArr := FloatStringsToSingleDynArray(ANode.Translate[i].Text);
    Result.FTransformation.m41 := LArr[0];
    Result.FTransformation.m42 := LArr[1];
    Result.FTransformation.m43 := LArr[2];
  end;

  for i := 0 to ANode.Scale.Count - 1 do
  begin
    LArr := FloatStringsToSingleDynArray(ANode.Scale[i].Text);
    UpdateMatrix(CreateScaleMatrix3D(Vector3D(LArr[0],LArr[1],LArr[2])));
  end;

  for i := 0 to ANode.Matrix.Count - 1 do
    Result.FTransformation := Matrix3D(FloatStringsToSingleDynArray(ANode.Matrix[i].Text));
end;

function TDAEModel.GetScene(const AScene: IXMLVisual_scene_type): TDAEVisualScene;
var
  i : Integer;
  LScene: TDAEVisualScene;
begin
  LScene := TDAEVisualScene.Create;

  SetLength(LScene.FNodes, AScene.Node.Count);
  for i := 0 to AScene.Node.Count-1 do
     LScene.FNodes[i] := GetNode(AScene.Node[i]);

  result := LScene;
end;

procedure TDAEModel.ImportFromEffectLib(const AEffectLib: IXMLLibrary_effects_type);
var
  i: Integer;
begin
  SetLength(FEffects, AEffectLib.Effect.Count);
  for i := 0 to AEffectLib.Effect.Count - 1 do
    FEffects[i] := GetEffect(AEffectLib.Effect[i]);
end;

procedure TDAEModel.ImportFromSceneLib(const ASceneLib: IXMLLibrary_visual_scenes_type);
var
  i: Integer;
begin
  SetLength(FSceneList, ASceneLib.Visual_scene.Count);
  for i := 0 to ASceneLib.Visual_scene.Count - 1 do
    FSceneList[i] := GetScene(ASceneLib.Visual_scene[i]);
end;

constructor TDAEModel.Create;
begin
  FMaterials := TGEMaterials.Create(True);
end;

destructor TDAEModel.Destroy();
var
  i:Integer;
begin
  for i := 0 to High(FImageList) do
    FImageList[i].Free;

  for i := 0 to High(FMeshes) do
    FMeshes[i].Free;

  FMaterials.Free;

  for i := 0 to High(FEffects) do
    FEffects[i].Free;

  for i := 0 to High(FSceneList) do
    FSceneList[i].Free;

  for i := 0 to High(FControllers) do
    FControllers[i].Free;

  for i := 0 to High(FAllNodes) do
    FAllNodes[i].Free;

  for i := 0 to High(FModels) do
    FModels[i].Free;
end;

{ TDAEVisualNode }

destructor TDAEVisualNode.Destroy;
begin
  inherited;
end;

end.
