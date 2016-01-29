unit m3BaseObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "m3$DB"
// ������: "w:/common/components/rtl/Garant/m3/m3BaseObject.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3$DB::m3DB::Tm3BaseObject
//
// ������� ���������� ������� ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3DBInterfaces,
  m3PrimDB,
  l3CProtoObject
  ;

type
 Tm3BaseObject = {abstract} class(Tl3CProtoObject, Im3DBObject)
  {* ������� ���������� ������� ���������. }
 private
 // private fields
   f_f_DB : Tm3PrimDB;
    {* ���� ��� �������� f_DB}
 protected
 // realized methods
   function DB: Im3DB;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // public methods
   constructor Create(aDB: Tm3PrimDB); reintroduce;
 protected
 // protected properties
   property f_DB: Tm3PrimDB
     read f_f_DB;
 end;//Tm3BaseObject

implementation

uses
  SysUtils
  ;

// start class Tm3BaseObject

constructor Tm3BaseObject.Create(aDB: Tm3PrimDB);
//#UC START# *555B269800C2_4742DC5C0219_var*
//#UC END# *555B269800C2_4742DC5C0219_var*
begin
//#UC START# *555B269800C2_4742DC5C0219_impl*
 inherited Create;
 aDB.SetRefTo(f_f_DB);
//#UC END# *555B269800C2_4742DC5C0219_impl*
end;//Tm3BaseObject.Create

function Tm3BaseObject.DB: Im3DB;
//#UC START# *4720847C026F_4742DC5C0219_var*
//#UC END# *4720847C026F_4742DC5C0219_var*
begin
//#UC START# *4720847C026F_4742DC5C0219_impl*
 Result := f_DB.AsDB;
//#UC END# *4720847C026F_4742DC5C0219_impl*
end;//Tm3BaseObject.DB

procedure Tm3BaseObject.Cleanup;
//#UC START# *479731C50290_4742DC5C0219_var*
//#UC END# *479731C50290_4742DC5C0219_var*
begin
//#UC START# *479731C50290_4742DC5C0219_impl*
 FreeAndNil(f_f_DB);
 inherited;
//#UC END# *479731C50290_4742DC5C0219_impl*
end;//Tm3BaseObject.Cleanup

end.