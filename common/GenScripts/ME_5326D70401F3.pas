unit l3Variants;

// ������: "w:\common\components\rtl\Garant\L3\l3Variants.pas"
// ���������: "Interfaces"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
;

 (*
 Ml3Variant = interface
  function pm_GetAsWStr: Tl3WString;
  function pm_GetAsString: AnsiString;
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
  property AsWStr: Tl3WString
   read pm_GetAsWStr;
   {* �������� ��� �������������� � ���� Tl3PCharLen }
  property AsString: AnsiString
   read pm_GetAsString;
   {* �������� ��� �������������� � ������� Delphi }
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
