unit NOT_FINISHED_evdSchema;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evdSchema.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Schemas::evdSchema
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\Everest\evDefine.inc}

interface


implementation

uses
  evNative_Schema
  {$If defined(Archi)}
  ,
  evArchi_Schema
  {$IfEnd} //Archi
  
  {$If defined(evMyEditor)}
  ,
  My_Schema
  {$IfEnd} //evMyEditor
  ,
  Everest_Schema
  {$If defined(DesignTimeLibrary)}
  ,
  Design_Schema
  {$IfEnd} //DesignTimeLibrary
  
  ;

end.