unit evGeneratorUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/evGeneratorUtils.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Generators::evGeneratorUtils
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evdStyles,
  k2TagGen
  ;

procedure EvSetFilters4PDF(var aGenerator: Tk2TagGenerator;
  aHiddenStyles: TevStandardStyles);

implementation

uses
  evHiddenFilter,
  evdPageParamsFilter,
  evUserCommentFilter,
  evStyleHeaderAdder
  ;

// unit methods

procedure EvSetFilters4PDF(var aGenerator: Tk2TagGenerator;
  aHiddenStyles: TevStandardStyles);
//#UC START# *5549F1C50037_5549F1AA032E_var*
//#UC END# *5549F1C50037_5549F1AA032E_var*
begin
//#UC START# *5549F1C50037_5549F1AA032E_impl*
 TevdPageParamsFilter.SetToA4(aGenerator); // {Requestlink:564248678}: ������ �������� �4.
 {$IFNDEF Nemesis}
 TevStyleHeaderAdder.SetTo(aGenerator);
 {$ENDIF Nemesis}
 TevUserCommentFilter.SetTo(aGenerator);
 TevHiddenFilter.SetTo(aHiddenStyles, true, aGenerator);
//#UC END# *5549F1C50037_5549F1AA032E_impl*
end;//EvSetFilters4PDF

end.