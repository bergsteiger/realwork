unit l3Variants;

interface

uses
 l3IntfUses
 , l3Interfaces
;

 (*
 Ml3Variant = interface
  function AsBool: Boolean;
   {* ������������� � Boolean. }
  function AsLong: Integer;
  function IsNull: Boolean;
   {* ������ ���? }
  function IsTransparent: Boolean;
   {* ��� "����������"? }
  function IsValid: Boolean;
   {* ��� ����� ��������? }
  function IsStream(out theStream: IStream): Boolean;
   {* ��������� ����� �� ��� ����������� � ������. � �������� � ������ - ���� ��������� �� ����� - �� �������. }
  function MarkModified: Boolean;
 end;//Ml3Variant
 *)
 
 (*
 Mk2AtomHolder = interface
  function HasSubAtom(anIndex: Integer): Boolean;
 end;//Mk2AtomHolder
 *)
 
 (*
 Mk2TypeInfo = interface
  {* ���������� � ���� }
  function IsOrd: Boolean;
 end;//Mk2TypeInfo
 *)
 
implementation

uses
 l3ImplUses
;

end.
