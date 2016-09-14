unit msDiagrammStack;
// - ���� ��������

interface

uses
 Generics.Collections,
 msInterfaces
 ;

type
 TmsCurrentDiagrammRec = record
 public
  rDiagramms : ImsDiagrammsList;
  rDiagramm : ImsDiagramm;
  constructor Create(const aDiagramms : ImsDiagrammsList; const aDiagramm : ImsDiagramm);
 end;//TmsCurrentDiagrammRec

 TmsDiagrammStack = TStack<TmsCurrentDiagrammRec>;

implementation

constructor TmsCurrentDiagrammRec.Create(const aDiagramms : ImsDiagrammsList; const aDiagramm : ImsDiagramm);
begin
 Assert(aDiagramms <> nil);
 Assert(aDiagramm <> nil);
 Assert(aDiagramms.IndexOf(aDiagramm) >= 0);
 rDiagramms := aDiagramms;
 rDiagramm := aDiagramm;
end;

end.
