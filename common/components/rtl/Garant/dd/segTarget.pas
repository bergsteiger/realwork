unit segTarget;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "dd"
// ������: "w:/common/components/rtl/Garant/dd/segTarget.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::NSRCReaderCore::TsegTarget
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3ProtoObject
  ;

type
 TsegTarget = class(Tl3ProtoObject)
 private
 // private fields
   f_DocID : Integer;
    {* ���� ��� �������� DocID}
   f_SubID : Integer;
    {* ���� ��� �������� SubID}
 public
 // public methods
   constructor Create(aDocID: Integer;
     aSubID: Integer); reintroduce;
 public
 // public properties
   property DocID: Integer
     read f_DocID;
   property SubID: Integer
     read f_SubID;
 end;//TsegTarget

implementation

// start class TsegTarget

constructor TsegTarget.Create(aDocID: Integer;
  aSubID: Integer);
//#UC START# *55DC94FC0021_55DC6C1902EB_var*
//#UC END# *55DC94FC0021_55DC6C1902EB_var*
begin
//#UC START# *55DC94FC0021_55DC6C1902EB_impl*
 inherited Create;
 f_DocID := aDocID;
 f_SubID := aSubID;
//#UC END# *55DC94FC0021_55DC6C1902EB_impl*
end;//TsegTarget.Create

end.