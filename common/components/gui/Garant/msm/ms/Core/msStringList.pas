unit msStringList;

interface

uses
 {$Include msWatchedObject.mixin.pas}
 ,
 System.Classes
 ;

type
 TmsWatchedObjectParent = TStringList;
 {$Include msWatchedObject.mixin.pas}
 TmsStringList = class abstract(TmsWatchedObject)
 // - �����, ������� ����� ��������������� ��������/����������� ����� �����������
 end;//TmsStringList

implementation

uses
 {$Include msWatchedObject.mixin.pas}
;

{$Include msWatchedObject.mixin.pas}

end.
