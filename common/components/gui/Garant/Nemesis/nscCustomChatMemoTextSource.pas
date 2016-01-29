unit nscCustomChatMemoTextSource;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Nemesis/nscCustomChatMemoTextSource.pas"
// �����: 19.08.2009 12:06
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Nemesis::Memos::TnscCustomChatMemoTextSource
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  evCustomMemoTextSource,
  nevTools
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscCustomChatMemoTextSource = class(TevCustomMemoTextSource)
 protected
 // overridden protected methods
   function DoMakeDocumentContainer: InevDocumentContainer; override;
 end;//TnscCustomChatMemoTextSource
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  nscCustomChatMemoContainer
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TnscCustomChatMemoTextSource

function TnscCustomChatMemoTextSource.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_4A8BB2760229_var*
//#UC END# *482D9A030221_4A8BB2760229_var*
begin
//#UC START# *482D9A030221_4A8BB2760229_impl*
 Result := TnscCustomChatMemoContainer.Make;
//#UC END# *482D9A030221_4A8BB2760229_impl*
end;//TnscCustomChatMemoTextSource.DoMakeDocumentContainer

{$IfEnd} //Nemesis

end.