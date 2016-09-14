unit msDiagramms;

interface

uses
 System.Types,
 FMX.Objects,
 System.Classes,
 msCoreObjects,
 msShape,
 Data.DBXJSONReflect,
 msDiagramm,
 msInterfaces,
 msDiagrammsList
 ;

type
 TmsDiagramms = class(TmsDiagrammsList, ImsDiagramms)
 private
  constructor CreatePrim;
 protected
  procedure Serialize;
  procedure DeSerialize;
  procedure SaveTo(const aFileName: String); override;
  procedure LoadFrom(const aFileName: String); override;
  procedure Cleanup; override;
 public
  class function Create: ImsDiagramms;
  procedure Assign(anOther: TmsDiagramms);
 end;//TmsDiagramms

implementation

uses
 System.SysUtils,
 FMX.Graphics,
 System.UITypes,
 msDiagrammsMarshal,
 msRegisteredShapes,
 msInvalidators
 ;

// TmsDiagramms

procedure TmsDiagramms.Cleanup;
begin
 // - ��������� ����� ��� �������
 inherited;
end;

class function TmsDiagramms.Create: ImsDiagramms;
begin
 Result := CreatePrim;
end;

constructor TmsDiagramms.CreatePrim;
begin
 inherited Create;
end;

const
 c_FileName = 'All.json';

procedure TmsDiagramms.DeSerialize;
begin
 TmsDiagrammsMarshal.DeSerialize(c_FileName, self);
end;

procedure TmsDiagramms.Assign(anOther: TmsDiagramms);
begin
 inherited Assign(anOther);
end;

procedure TmsDiagramms.Serialize;
begin
 TmsDiagrammsMarshal.Serialize(c_FileName, self);
end;

procedure TmsDiagramms.SaveTo(const aFileName: String);
begin
 TmsDiagrammsMarshal.Serialize(aFileName, Self);
end;

procedure TmsDiagramms.LoadFrom(const aFileName: String);
begin
 TmsDiagrammsMarshal.DeSerialize(aFileName, Self);
end;

end.

