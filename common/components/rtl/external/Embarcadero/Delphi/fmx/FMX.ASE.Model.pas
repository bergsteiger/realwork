{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.ASE.Model;

interface

uses
  System.SysUtils, System.Classes, System.TypInfo, FMX.Types3D, System.Types,
  FMX.ASE.Lexer, FMX.Import;

type
  TAseMaterial = class;
  TAseMaterialDynArray = array of TAseMaterial;

  TAseMaterial = class(TGEMaterial)
  private
    FSubMaterials: TGEMaterials;
  public
    property SubMaterials: TGEMaterials read FSubMaterials;
    constructor Create;
    destructor Destroy; override;
  end;

  TAseMesh = record
    FVertexSource: TGEVertexSource;
    FTriangleMesh: TGETriangleMeshID;
    FFaceMaterials : TIntegerDynArray;
    FSubMeshes: array of TGEMesh;
  end;
  TAseMeshDynArray = array of TAseMesh;

  TAseModel = class(TCustomModel)
  private
     FMaterials: TGEMaterials;
     FMeshes: TAseMeshDynArray;

     procedure ParseVertexList(
        const ALexer : TAseLexer;
        const ANumVertex: Integer;
        const AVertexSource: TGEVertexSource);

     procedure ParseNormalList(
        const ALexer : TAseLexer;
        const ANumFaceNormal: Integer;
        const ANumVertexNormal: Integer;
          var AMesh: TAseMesh);

     procedure ParseTexCoordList(
        const ALexer : TAseLexer;
        const ANumTexCoord: Integer;
        const AVertexSource: TGEVertexSource);

     procedure ParseFaceList(
        const ALexer : TAseLexer;
        const ANumFaces: Integer;
        var AMesh: TAseMesh);

      procedure ParseTFaceList(
        const ALexer : TAseLexer;
        const ANumFaces: Integer;
        var AMesh: TAseMesh);

     procedure ParseMesh(const ALexer : TAseLexer; var AMesh : TAseMesh);

     procedure ParseMap(const ALexer : TAseLexer; var AFileName: String);
     procedure ParseMaterialList(const ALexer : TAseLexer);
     procedure ParseMaterial(const ALexer : TAseLexer; AMaterial: TAseMaterial);

     procedure ParseGeometry(const ALexer : TAseLexer);
     procedure ParseModel(const ALexer : TAseLexer);

     function AddSubMesh(const AVertexSource: TGEVertexSource): TGEMesh;
  public
     property Meshes: TAseMeshDynArray read FMeshes;
     property Materials: TGeMaterials read FMaterials;

     procedure LoadFromFile(const AFileName: String); override;
     constructor Create;
     destructor Destroy; override;
  end;

  EAseParserError = class(Exception);

implementation

uses
  FMX.Consts;

type
  TAseLexerHack = class(TAseLexer);

constructor TAseModel.Create;
begin
  FMaterials := TGEMaterials.Create(True);
end;

destructor TAseModel.Destroy;
var
  i , j: Integer;
begin
  for i := 0 to High(FMeshes) do
    for j := 0 to High(FMeshes[i].FSubMeshes) do
      FMeshes[i].FSubMeshes[j].Free;
  FMaterials.Free;
end;

procedure TAseModel.ParseMap(const ALexer : TAseLexer; var AFileName: String);
var
    ExpectedTokenOk: boolean;
begin
  ALexer.NextTokenExpected(atOpenBracket);
  while not (ALexer.NextToken in [atEOF, atCloseBracket]) do
  begin
    if (ALexer.IsExpectedToken(atKeyWord)) then
    begin
      case ALexer.TokenKeyWord of
        kw_BITMAP:
        begin
          ALexer.NextTokenExpected(atString);
          if ALexer.IsExpectedToken(atString) then
            AFileName := ALexer.TokenString;
        end;
      else
        ALexer.SkipKeyWordBlock;
      end;
    end;
  end;
  ExpectedTokenOk := ALexer.IsExpectedToken(atCloseBracket);
  if not ExpectedTokenOk then
    raise EAseLexerError.CreateRes(@SAseLexerFileCorruption);
end;


procedure TAseModel.ParseMaterial(const ALexer : TAseLexer; AMaterial: TAseMaterial);
var
  LNumSubmaterials, LSubmaterial: Integer;
  ExpectedTokenOk: Boolean;
begin
//  ALexer.NextTokenExpected(atInteger);
//  if (LIdx < 0) or (LIdx >= ANumTexCoord) then
//    ALexer.Error('');
  ALexer.NextTokenExpected(atOpenBracket);

  while not (ALexer.NextToken in [atEOF, atCloseBracket]) do
  begin
    if (ALexer.IsExpectedToken(atKeyWord)) then
    begin
      case ALexer.TokenKeyWord of
        kw_MATERIAL_AMBIENT:
        begin
            ALexer.NextTokenExpected(atFloat);
            AMaterial.FAmbient.X := ALexer.TokenFloat;
            ALexer.NextTokenExpected(atFloat);
            AMaterial.FAmbient.Y := ALexer.TokenFloat;
            ALexer.NextTokenExpected(atFloat);
            AMaterial.FAmbient.Z := ALexer.TokenFloat;
        end;
        kw_MATERIAL_DIFFUSE:
        begin
            ALexer.NextTokenExpected(atFloat);
            AMaterial.FDiffuse.X := ALexer.TokenFloat;
            ALexer.NextTokenExpected(atFloat);
            AMaterial.FDiffuse.Y := ALexer.TokenFloat;
            ALexer.NextTokenExpected(atFloat);
            AMaterial.FDiffuse.Z := ALexer.TokenFloat;
        end;
        kw_MATERIAL_SPECULAR:
        begin
            ALexer.NextTokenExpected(atFloat);
            AMaterial.FSpecular.X := ALexer.TokenFloat;
            ALexer.NextTokenExpected(atFloat);
            AMaterial.FSpecular.Y := ALexer.TokenFloat;
            ALexer.NextTokenExpected(atFloat);
            AMaterial.FSpecular.Z := ALexer.TokenFloat;
        end;
        kw_MAP_DIFFUSE:
        begin
           ParseMap(ALexer, AMaterial.FDiffuseMap);
        end;
        kw_NUMSUBMTLS:
        begin
            ALexer.NextTokenExpected(atInteger);
            LNumSubmaterials := ALexer.TokenInteger;
            AMaterial.FSubMaterials.Count := LNumSubmaterials;
        end;
        kw_SUBMATERIAL:
        begin
            ALexer.NextTokenExpected(atInteger);
            LSubmaterial := ALexer.TokenInteger;
            AMaterial.FSubMaterials[LSubmaterial] := TaseMaterial.Create;
            AMaterial.FSubMaterials[LSubmaterial].FName := AMaterial.FName + 'sub'+ IntToStr(LSubmaterial);
            ParseMaterial(ALexer, TAseMaterial(AMaterial.FSubMaterials[LSubmaterial]));

        end;
      else
        ALexer.SkipKeyWordBlock;
      end;
    end;
  end;

  ExpectedTokenOk:= ALexer.IsExpectedToken(atCloseBracket);
  if not ExpectedTokenOk then
    raise EAseLexerError.CreateRes(@SAseLexerFileCorruption);
end;

procedure TAseModel.ParseMaterialList(const ALexer : TAseLexer);
var
  LNumMaterials: Integer;
  LIdx: Integer;
  ExpectedTokenOk: Boolean;
begin
  LNumMaterials := 0;
  ALexer.NextTokenExpected(atOpenBracket);
  while not (ALexer.NextToken in [atEOF, atCloseBracket]) do
  begin

    if ALexer.IsExpectedToken(atKeyWord) then
    begin
      case ALexer.TokenKeyWord of
        kw_MATERIAL_COUNT:
        begin
          ALexer.NextTokenExpected(atInteger);
          LNumMaterials := ALexer.TokenInteger;
          FMaterials.Count := LNumMaterials;
        end;
        kw_MATERIAL:
          begin
            ALexer.NextTokenExpected(atInteger);
            LIdx := ALexer.TokenInteger;

            if (LIdx < 0) or (LIdx >= LNumMaterials) then
              raise EAseParserError.CreateRes(@SAseParserWrongMaterialsNumError);
            FMaterials[LIdx] := TaseMaterial.Create;
            FMaterials[LIdx].FName := IntToStr(LIdx);
            ParseMaterial(ALexer, TAseMaterial(FMaterials.Items[LIdx]));
          end;
      else
        ALexer.SkipKeyWordBlock;
      end;
    end;
  end;
  ExpectedTokenOk:= ALexer.IsExpectedToken(atCloseBracket);
  if not ExpectedTokenOk then
    raise EAseLexerError.CreateRes(@SAseLexerFileCorruption);
end;


procedure TAseModel.ParseVertexList(
  const ALexer : TAseLexer;
  const ANumVertex: Integer;
  const AVertexSource: TGEVertexSource);
var
  LNumVertex: Integer;
  LIdx: Integer;
  LPositions: TPoint3DDynArray;
  ExpectedTokenOk: Boolean;
begin
  ALexer.NextTokenExpected(atOpenBracket);
  LNumVertex := 0;
  SetLength(LPositions, ANumVertex);

  while not (ALexer.NextToken in [atEOF, atCloseBracket]) do
  begin
    if ALexer.IsExpectedToken(atKeyWord) then
    begin
      case ALexer.TokenKeyWord of
        kw_MESH_VERTEX:
          begin
            Inc(LNumVertex);
            if (LNumVertex > ANumVertex) then
              raise EAseParserError.CreateRes(@SAseParserWrongVertexNumError);
            ALexer.NextTokenExpected(atInteger);

            LIdx := ALexer.TokenInteger;
            if (LIdx < 0) or (LIdx >= ANumVertex) then
              raise EAseParserError.CreateRes(@SAseParserWrongVertexIdxError);

            ALexer.NextTokenExpected(atFloat);
            LPositions[LIdx].X := ALexer.TokenFloat;
            ALexer.NextTokenExpected(atFloat);
            LPositions[LIdx].Y := ALexer.TokenFloat;
            ALexer.NextTokenExpected(atFloat);
            LPositions[LIdx].Z := ALexer.TokenFloat;
          end;
      else
        ALexer.SkipKeyWordBlock;
      end;
    end;
  end;

  ExpectedTokenOk:= ALexer.IsExpectedToken(atCloseBracket);
  if not ExpectedTokenOk then
    raise EAseLexerError.CreateRes(@SAseLexerFileCorruption);
  if (ANumVertex <> LNumVertex) then
    raise EAseParserError.CreateRes(@SAseParserWrongVertexNumError);

  AVertexSource.PositionSource := LPositions;
end;

procedure TAseModel.ParseNormalList(
    const ALexer : TAseLexer;
    const ANumFaceNormal: Integer;
    const ANumVertexNormal: Integer;
    var AMesh: TAseMesh);
var
  LNumVertexNormal: Integer;
  LVertexNormals: TPoint3DDynArray;
  LNumFaceNormal: Integer;
  LFaceNormals: TPoint3DDynArray;
  ExpectedTokenOk: Boolean;
begin
  ALexer.NextTokenExpected(atOpenBracket);
  LNumVertexNormal := 0;
  SetLength(LVertexNormals, ANumVertexNormal);
  LNumFaceNormal:= 0;
  SetLength(LFaceNormals, ANumFaceNormal);

  while not (ALexer.NextToken in [atEOF, atCloseBracket]) do
  begin
    if ALexer.IsExpectedToken(atKeyWord) then
    begin
      case ALexer.TokenKeyWord of
        kw_MESH_FACENORMAL:
        begin
           if (LNumFaceNormal > ANumFaceNormal) then
              raise EAseParserError.CreateRes(@SAseParserWrongNormalNumError);
            ALexer.NextTokenExpected(atInteger);
            LNumFaceNormal:= ALexer.TokenInteger;

            ALexer.NextTokenExpected(atFloat);
            LFaceNormals[LNumFaceNormal].X := ALexer.TokenFloat;
            ALexer.NextTokenExpected(atFloat);
            LFaceNormals[LNumFaceNormal].Y := ALexer.TokenFloat;
            ALexer.NextTokenExpected(atFloat);
            LFaceNormals[LNumFaceNormal].Z := ALexer.TokenFloat;

                                                                                                                            
                                                                                                                                 

//            AMesh.FTriangleMesh[LNumNormal div 3][LNumNormal mod 3].Normal := LNumNormal;
            {This comment out because that are tools that they don't export these parameters in order}
//            Inc(LNumFaceNormal);
        end;
        kw_MESH_VERTEXNORMAL:
          begin
            if (LNumVertexNormal > ANumVertexNormal) then
              raise EAseParserError.CreateRes(@SAseParserWrongNormalNumError);
            ALexer.NextTokenExpected(atInteger);
            LNumVertexNormal:= ALexer.TokenInteger;

            ALexer.NextTokenExpected(atFloat);
            LVertexNormals[LNumVertexNormal].X := ALexer.TokenFloat;
            ALexer.NextTokenExpected(atFloat);
            LVertexNormals[LNumVertexNormal].Y := ALexer.TokenFloat;
            ALexer.NextTokenExpected(atFloat);
            LVertexNormals[LNumVertexNormal].Z := ALexer.TokenFloat;

            AMesh.FTriangleMesh[LNumVertexNormal div 3][LNumVertexNormal mod 3].Normal := LNumVertexNormal;
            {This comment out because that are tools that they don't export these parameters in order}
//            Inc(LNumVertexNormal);
         end;
      else
        ALexer.SkipKeyWordBlock;
      end;
    end;
  end;

  ExpectedTokenOk:= ALexer.IsExpectedToken(atCloseBracket);
  if not ExpectedTokenOk then
    raise EAseLexerError.CreateRes(@SAseLexerFileCorruption);
//  if (ANumFaceNormal <> LNumFaceNormal) or (ANumVertexNormal <> LNumVertexNormal) then
//    raise EAseParserError.CreateRes(@SAseParserWrongNormalNumError);

  AMesh.FVertexSource.NormalSource := LVertexNormals;
end;

procedure TAseModel.ParseTexCoordList(
    const ALexer : TAseLexer;
    const ANumTexCoord: Integer;
    const AVertexSource: TGEVertexSource);
var
  LNumTexCoord: Integer;
  LIdx: Integer;
  LTexCoord: TPointFDynArray;
  ExpectedTokenOk: Boolean;
begin
  ALexer.NextTokenExpected(atOpenBracket);
  LNumTexCoord := 0;
  SetLength(LTexCoord, ANumTexCoord);

  while not (ALexer.NextToken in [atEOF, atCloseBracket]) do
  begin
    if ALexer.IsExpectedToken(atKeyWord) then
    begin
      case ALexer.TokenKeyWord of
        kw_MESH_TVERT:
          begin
            Inc(LNumTexCoord);
            if (LNumTexCoord > ANumTexCoord) then
              raise EAseParserError.CreateRes(@SAseParserWrongTexCoordNumError);
            ALexer.NextTokenExpected(atInteger);
            LIdx := ALexer.TokenInteger;
            if (LIdx < 0) or (LIdx >= ANumTexCoord) then
              raise EAseParserError.CreateRes(@SAseParserWrongTexCoordIdxError);

            ALexer.NextTokenExpected(atFloat);
            LTexCoord[LIdx].X := ALexer.TokenFloat;
            ALexer.NextTokenExpected(atFloat);
            LTexCoord[LIdx].Y := ALexer.TokenFloat;
            ALexer.NextTokenExpected(atFloat);
            ALexer.TokenFloat;
          end;
      else
        ALexer.SkipKeyWordBlock;
      end;
    end;
  end;

  ExpectedTokenOk:= ALexer.IsExpectedToken(atCloseBracket);
  if not ExpectedTokenOk then
    raise EAseLexerError.CreateRes(@SAseLexerFileCorruption);
  if (ANumTexCoord <> LNumTexCoord) then
    raise EAseParserError.CreateRes(@SAseParserWrongTexCoordNumError);

  AVertexSource.Texture0Source := LTexCoord;
end;

procedure TAseModel.ParseFaceList(
  const ALexer : TAseLexer;
  const ANumFaces: Integer;
  var AMesh: TAseMesh);
var
  LTriangle: ^TGETriangleID;
  LNumFaces: Integer;
  LIdx, LSmoothGroup: Integer;
  LC: char;
  ExpectedTokenOk: Boolean;
begin
  ALexer.NextTokenExpected(atOpenBracket);
  LNumFaces := 0;
  LIdx := -1;
  LTriangle := nil;
  while not (ALexer.NextToken in [atEOF, atCloseBracket]) do
  begin
    case ALexer.Token of
      atKeyWord:
        case ALexer.TokenKeyWord of
          kw_MESH_MTLID:
            begin
              ALexer.NextTokenExpected(atInteger);
              AMesh.FFaceMaterials[LIdx] := ALexer.TokenInteger;
            end;

          kw_MESH_SMOOTHING:
            begin
              ALexer.UseCommaToken := True;
              {Some tools use to export all the parameters even they are disabled or they don't have any relevance.
                Here is the case of the smooth group parameter.}
//              ALexer.NextTokenExpected(atInteger);
              ALexer.NextToken;
              LSmoothGroup:= 0;
              if Alexer.Token = atInteger then
              begin
                LSmoothGroup := ALexer.TokenInteger;
                while ALexer.NextToken = atComma do
                  ALexer.NextTokenExpected(atInteger);
              end
              else
                if (ALexer.Token = atKeyWord) and (ALexer.TokenKeyWord = kw_MESH_MTLID) then
                  LSmoothGroup :=  0;

              ALexer.Ahead := true;
              ALExer.UseCommaToken := False;

              if Assigned(LTriangle) then
              begin
                LTriangle[0].SmoothGroup := LSmoothGroup;
                LTriangle[1].SmoothGroup := LSmoothGroup;
                LTriangle[2].SmoothGroup := LSmoothGroup;
              end;
            end;

          kw_MESH_FACE:
            begin
              if (LNumFaces > ANumFaces) then
                raise EAseParserError.CreateRes(@SAseParserWrongFacesNumError);

              ALexer.NextTokenExpected(atInteger);
              LIdx := ALexer.TokenInteger;
              if (LIdx < 0) or (LIdx >= ANumFaces) then
                raise EAseParserError.CreateRes(@SAseParserWrongFacesIdxError);

              LTriangle := @AMesh.FTriangleMesh[LIdx];
              LTriangle[0] := NullVertexID;
              LTriangle[1] := NullVertexID;
              LTriangle[2] := NullVertexID;

              Inc(LNumFaces);
            end;
        else
          ALexer.SkipKeyWordBlock;
        end;
      atIdent:
        begin
          if LIdx = -1 then
            raise EAseParserError.CreateRes(@SAseParserWrongFacesIdxError);

          case Length(ALexer.TokenIdent) of
            1:
              begin
                LC := ALexer.TokenIdent[1];
                ALexer.NextTokenExpected(atColon);
                ALexer.NextTokenExpected(atInteger);
                case LC of
                  'A': LTriangle[0].Position := ALexer.TokenInteger;
                  'B': LTriangle[1].Position := ALexer.TokenInteger;
                  'C': LTriangle[2].Position := ALexer.TokenInteger;
                end;
              end;
          //  2:
          else
            ALexer.NextTokenExpected(atColon);
            ALexer.NextTokenExpected(atInteger);
            Continue;
          end;
        end;
      atColon:
      begin

      end
    else
      raise EAseParserError.CreateRes(@SAseParserUnexpectedKyWordError);
    end;
  end;

  ExpectedTokenOk:= ALexer.IsExpectedToken(atCloseBracket);
  if not ExpectedTokenOk then
    raise EAseLexerError.CreateRes(@SAseLexerFileCorruption);
  if (ANumFaces <> LNumFaces) then
    raise EAseParserError.CreateRes(@SAseParserWrongFacesNumError);
end;

procedure TAseModel.ParseTFaceList(
  const ALexer : TAseLexer;
  const ANumFaces: Integer;
  var AMesh: TAseMesh);
var
  LNumFace: Integer;
  LIdx: Integer;
  ExpectedTokenOk: Boolean;
begin
  ALexer.NextTokenExpected(atOpenBracket);
  LNumFace := 0;

  while not (ALexer.NextToken in [atEOF, atCloseBracket]) do
  begin
    if ALexer.IsExpectedToken(atKeyWord) then
    begin
      case ALexer.TokenKeyWord of
        kw_MESH_TFACE:
          begin
            Inc(LNumFace);
            if (LNumFace > Length(AMesh.FTriangleMesh)) then
              raise EAseParserError.CreateRes(@SAseParserWrongTriangleMeshNumError);
            ALexer.NextTokenExpected(atInteger);
            LIdx := ALexer.TokenInteger;
            if (LIdx < 0) or (LIdx > High(AMesh.FTriangleMesh)) then
              raise EAseParserError.CreateRes(@SAseParserWrongTriangleMeshIdxError);

            ALexer.NextTokenExpected(atInteger);
            AMesh.FTriangleMesh[LIdx][0].Texture0 := ALexer.TokenInteger;
            ALexer.NextTokenExpected(atInteger);
            AMesh.FTriangleMesh[LIdx][1].Texture0 := ALexer.TokenInteger;
            ALexer.NextTokenExpected(atInteger);
            AMesh.FTriangleMesh[LIdx][2].Texture0 := ALexer.TokenInteger;
          end;
      else
        ALexer.SkipKeyWordBlock;
      end;
    end;
  end;

  ExpectedTokenOk:= ALexer.IsExpectedToken(atCloseBracket);
  if not ExpectedTokenOk then
    raise EAseLexerError.CreateRes(@SAseLexerFileCorruption);
  if (Length(AMesh.FTriangleMesh) <> LNumFace) then
    raise EAseParserError.CreateRes(@SAseParserWrongTriangleMeshNumError);

end;

function TAseModel.AddSubMesh(const AVertexSource: TGEVertexSource): TGEMesh;
var
  LMesh: ^TAseMesh;
begin
  result := TGEMesh.Create(AVertexSource);
  LMesh := @FMeshes[High(FMeshes)];
  SetLength(LMesh.FSubMeshes, Length(LMesh.FSubMeshes) + 1);
  LMesh.FSubMeshes[High(LMesh.FSubMeshes)] := result;
end;

procedure TAseModel.ParseMesh(const ALexer : TAseLexer; var AMesh : TAseMesh);
var
  LNumVertex, LNumFaces, LNumTVVertex: Integer;
  ExpectedTokenOk: Boolean;
begin
  ALexer.NextTokenExpected(atOpenBracket);
  LNumFaces := 0;
  LNumVertex := 0;
  LNumTVVertex := 0;

  while not (ALexer.NextToken in [atEOF, atCloseBracket]) do
  begin
    if ALexer.IsExpectedToken(atKeyWord) then
    begin
      case ALexer.TokenKeyWord of
        kw_MESH_NUMVERTEX:
          begin
            ALexer.NextTokenExpected(atInteger);
            LNumVertex := ALexer.TokenInteger;
          end;
        kw_MESH_NUMFACES:
          begin
            ALexer.NextTokenExpected(atInteger);
            LNumFaces := ALexer.TokenInteger;
            SetLength(AMesh.FTriangleMesh, LNumFaces);
            SetLength(AMesh.FFaceMaterials, LNumFaces);
          end;
        kw_MESH_NUMTVERTEX:
          begin
            ALexer.NextTokenExpected(atInteger);
            LNumTVVertex := ALexer.TokenInteger;
          end;
        kw_MESH_VERTEX_LIST:
            ParseVertexList(ALexer, LNumVertex, AMesh.FVertexSource);
        kw_MESH_TVERTLIST:
           ParseTexCoordList(ALexer, LNumTVVertex, AMesh.FVertexSource);
        kw_MESH_NORMALS:
           ParseNormalList(ALexer, LNumFaces, LNumVertex, AMesh);
        kw_MESH_FACE_LIST:
           ParseFaceList(ALexer, LNumFaces, AMesh);
        kw_MESH_TFACELIST:
           ParseTFaceList(ALexer, LNumFaces, AMesh);
      else
        ALexer.SkipKeyWordBlock;
      end;
    end;
  end;
  ExpectedTokenOk:= ALexer.IsExpectedToken(atCloseBracket);
  if not ExpectedTokenOk then
    raise EAseLexerError.CreateRes(@SAseLexerFileCorruption);
end;

procedure TAseModel.ParseGeometry(const ALexer : TAseLexer);
var
  LMaterialRef,  LSubMaterial, i: Integer;
  LMeshData: TAseMesh;
  LMesh: TGEMesh;
  ExpectedTokenOk: Boolean;
begin
  LMeshData.FVertexSource := TGEVertexSource.Create;

  ALexer.NextTokenExpected(atOpenBracket);
  LMaterialRef := -1;

  while not (ALexer.NextToken in [atEOF, atCloseBracket]) do
  begin
    if ALexer.IsExpectedToken(atKeyWord) then
    begin
      case ALexer.TokenKeyWord of
        kw_MESH:
           ParseMesh(ALexer, LMeshData);
        kw_MATERIAL_REF:
         begin
           ALexer.NextTokenExpected(atInteger);
           LMaterialRef := ALexer.TokenInteger;

         end;
      else
        ALexer.SkipKeyWordBlock;
      end;
    end;
  end;

  ExpectedTokenOk:= ALexer.IsExpectedToken(atCloseBracket);
  if not ExpectedTokenOk then
    raise EAseLexerError.CreateRes(@SAseLexerFileCorruption);

  SetLength(FMeshes, Length(FMeshes) + 1);
  FMeshes[high(FMeshes)] := LMeshData;

  LSubMaterial := -1;
  LMesh := nil;
  if (LMaterialRef <> -1) and
     (TAseMaterial(FMaterials[LMaterialRef]).FSubMaterials.Count > 0) then
  begin
    for i := 0 to High(LMeshData.FFaceMaterials) do
    begin
      if (LSubMaterial <> LMeshData.FFaceMaterials[i]) then
      begin
         LSubMaterial := LMeshData.FFaceMaterials[i];
         LMesh := AddSubMesh(LMeshData.FVertexSource);
         LMesh.MaterialName := IntToStr(LMaterialRef)+ 'sub' + inttostr(LSubMaterial);
      end;
      LMesh.AddTriangle(LMeshData.FTriangleMesh[i]);
    end;
  end else
  begin
    LMesh := AddSubMesh(LMeshData.FVertexSource);
    LMesh.AddTriangleMesh(LMeshData.FTriangleMesh);
    LMesh.MaterialName := inttostr(LMaterialRef);
  end;

  LMeshData.FVertexSource.Free;
end;

procedure TAseModel.ParseModel(const ALexer : TAseLexer);
begin
  while (ALexer.NextToken <> atEOF) do
  begin
    case ALexer.Token of
      atKeyWord:
        begin
          case ALexer.TokenKeyWord of
            kw_MATERIAL_LIST:
              ParseMaterialList(ALexer);
            kw_GEOMOBJECT:
              ParseGeometry(ALexer);
          else
            ALexer.SkipKeyWordBlock;
          end;
        end;
    else
      ALexer.IsExpectedToken(atKeyWord);
    end;
  end;
end;

procedure TAseModel.LoadFromFile(const AFileName: String);
var
  LLexer : TAseLexer;
begin
  LLexer := TAseLexer.Create(AFileName);
  ParseModel(LLexer);
  LLexer.Free;
end;

{ TAseMaterial }

constructor TAseMaterial.Create;
begin
  FSubMaterials := TGEMaterials.Create(True);
end;

destructor TAseMaterial.Destroy;
begin
  FSubMaterials.Free;

  inherited;
end;

end.
