unit NOT_FINISHED_OvcCmd;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Orpheus"
// ������: "w:/common/components/rtl/external/Orpheus/NOT_FINISHED_OvcCmd.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::Orpheus::OvcCmd
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\Orpheus\OVC.INC}

interface

const
  { Command Tables }
 

type
 TUserCommandEvent = function (Sender: TObject;
  Command: Word): Boolean of object;

implementation

end.