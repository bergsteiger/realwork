unit msInterfacedRefcounted;

interface

uses
 {$Include msWatchedObject.mixin.pas}
;

type
 TmsWatchedObjectParent = TInterfacedObject;
 {$Include msWatchedObject.mixin.pas}
 TmsInterfacedRefcounted = class abstract(TmsWatchedObject)
  // ���������� ��������, ����������� ����������. � ����ר��� ������.
  //
  // �� ����� ������� ����������, ����� ���������� ��� - http://18delphi.blogspot.ru/2013/04/iunknown.html
  // �� � ������ ARC - ���������� ���� "�������� ����������"
  //
  // ���� ��� ���� ��� ��� "��������":
  // - http://18delphi.blogspot.ru/2013/07/blog-post_3683.html
  // - http://18delphi.blogspot.ru/2013/07/1.html
  // - http://18delphi.blogspot.ru/2013/07/2.html
  // - http://18delphi.blogspot.ru/2013/07/2_18.html
  // - http://18delphi.blogspot.ru/2013/07/blog-post_8789.html
 protected
  //function IsClassTypeNamedAs(const aClassName: String): Boolean; virtual;
  procedure InstanceAllocated; override;
  // ms-help://embarcadero.rs_xe7/libraries/System.TObject.NewInstance.html
 end;//TmsInterfacedRefcounted

implementation

uses
 {$Include msWatchedObject.mixin.pas}
 ;

{$Include msWatchedObject.mixin.pas}

// TmsInterfacedRefcounted

procedure TmsInterfacedRefcounted.InstanceAllocated;
begin
 inherited;
 FRefCount := 1;
end;

end.
