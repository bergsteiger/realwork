unit Masks;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Rtl"
// Модуль: "w:/common/components/rtl/external/NotFinished/Borland/Delphi/Rtl/Common/Masks.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Rtl::Rtl::Common::Masks
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  SysUtils
  ;

type
 EMaskException = class(Exception)
 end;//EMaskException

 TMask = class
  {* TMask allows the comparison of strings containing wildcards to a file mask. }
 end;//TMask

function MatchesMask(const Filename: AnsiString;
  const Mask: AnsiString): Boolean;
   {* Indicates whether a file name conforms to the format specified by a filter string. }

implementation

// unit methods

function MatchesMask(const Filename: AnsiString;
  const Mask: AnsiString): Boolean;
//#UC START# *50254A2603D3_502549AF030B_var*
//#UC END# *50254A2603D3_502549AF030B_var*
begin
//#UC START# *50254A2603D3_502549AF030B_impl*
 !!! Needs to be implemented !!!
//#UC END# *50254A2603D3_502549AF030B_impl*
end;//MatchesMask

end.