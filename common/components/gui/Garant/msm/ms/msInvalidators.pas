unit msInvalidators;

interface

uses
 Generics.Collections,
 msInterfaces
 ;

type
 TmsInvalidatorsList = TList<TmsWeakInvalidatorRef>;
 // - ���������� - ������ - ������ (https://ru.wikipedia.org/wiki/%D0%A1%D0%BB%D0%B0%D0%B1%D0%B0%D1%8F_%D1%81%D1%81%D1%8B%D0%BB%D0%BA%D0%B0) ������
 // https://ru.wikipedia.org/wiki/%D0%9D%D0%B0%D0%B1%D0%BB%D1%8E%D0%B4%D0%B0%D1%82%D0%B5%D0%BB%D1%8C_(%D1%88%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD_%D0%BF%D1%80%D0%BE%D0%B5%D0%BA%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F)
 (*
  ����������� (����. Observer) � ������������� ������ ��������������. ����� �������� ��� ����������� (Dependents), ���������-��������� (Publisher-Subscriber). ������� �������� � ������, ������� ��������� �������� ���������� ������� ����� ������ ���������� �� ������ �������� �� ��������� �� ���������, ��� ����� �������� �� ����[2].
 *)

 TmsInvalidatorLambda = reference to procedure (const anItem: ImsInvalidator);

 TmsInvalidators = class
 // [����������� (������ ��������������)|https://ru.wikipedia.org/wiki/%D0%9D%D0%B0%D0%B1%D0%BB%D1%8E%D0%B4%D0%B0%D1%82%D0%B5%D0%BB%D1%8C_(%D1%88%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD_%D0%BF%D1%80%D0%BE%D0%B5%D0%BA%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F)]
 strict private
  class var f_Subscribers : TmsInvalidatorsList;
 public
  class destructor Fini;
 private
  class procedure DoItems(aLambda: TmsInvalidatorLambda);
 public
  class procedure InvalidateDiagramm(const aDiagramm: ImsDiagramm);
  class procedure DiagrammAdded(const aDiagramms: ImsDiagrammsList; const aDiagramm: ImsDiagramm);
  class procedure Subscribe(const anInvalidator: ImsInvalidator);
  // - �������������
  class procedure UnSubscribe(const anInvalidator: ImsInvalidator);
  // - ������������
 end;//TmsInvalidators

implementation

uses
 SysUtils
 ;

// TmsInvalidators

class destructor TmsInvalidators.Fini;
begin
 FreeAndNil(f_Subscribers);
end;

class procedure TmsInvalidators.DoItems(aLambda: TmsInvalidatorLambda);
var
 l_Subscriber : TmsWeakInvalidatorRef;
begin
 if (f_Subscribers <> nil) then
  for l_Subscriber in f_Subscribers do
   aLambda(l_Subscriber);
end;

class procedure TmsInvalidators.InvalidateDiagramm(const aDiagramm: ImsDiagramm);
begin
 DoItems(
  procedure (const anItem: ImsInvalidator)
  begin
   anItem.InvalidateDiagramm(aDiagramm)
  end
 );
end;

class procedure TmsInvalidators.DiagrammAdded(const aDiagramms: ImsDiagrammsList; const aDiagramm: ImsDiagramm);
begin
 DoItems(
  procedure (const anItem: ImsInvalidator)
  begin
   anItem.DiagrammAdded(aDiagramms, aDiagramm)
  end
 );
end;

class procedure TmsInvalidators.Subscribe(const anInvalidator: ImsInvalidator);
// - �������������
begin
 if (f_Subscribers = nil) then
  f_Subscribers := TmsInvalidatorsList.Create;
 if (f_Subscribers.IndexOf(anInvalidator) < 0) then
  f_Subscribers.Add(anInvalidator);
end;

class procedure TmsInvalidators.UnSubscribe(const anInvalidator: ImsInvalidator);
// - ������������
begin
 if (f_Subscribers <> nil) then
  f_Subscribers.Remove(anInvalidator);
end;

end.
