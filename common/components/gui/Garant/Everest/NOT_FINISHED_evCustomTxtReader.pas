unit NOT_FINISHED_evCustomTxtReader;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evCustomTxtReader.pas"
// �����: 05.10.1999 17:44
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Readers::TevCustomTxtReader
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Base,
  k2CustomFileReader
  ;

type
 TevCustomTxtReader = class(Tk2CustomFileReader)
 protected
 // protected methods
   procedure DoText(aText: Tl3String); virtual;
   function NeedOpenDefaultChild(aText: Tl3String): Boolean; virtual;
 end;//TevCustomTxtReader

implementation

// start class TevCustomTxtReader

procedure TevCustomTxtReader.DoText(aText: Tl3String);
//#UC START# *4D6BB62C01C8_482D6E3B02A3_var*
//#UC END# *4D6BB62C01C8_482D6E3B02A3_var*
begin
//#UC START# *4D6BB62C01C8_482D6E3B02A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D6BB62C01C8_482D6E3B02A3_impl*
end;//TevCustomTxtReader.DoText

function TevCustomTxtReader.NeedOpenDefaultChild(aText: Tl3String): Boolean;
//#UC START# *4E0B6520020B_482D6E3B02A3_var*
//#UC END# *4E0B6520020B_482D6E3B02A3_var*
begin
//#UC START# *4E0B6520020B_482D6E3B02A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E0B6520020B_482D6E3B02A3_impl*
end;//TevCustomTxtReader.NeedOpenDefaultChild

end.