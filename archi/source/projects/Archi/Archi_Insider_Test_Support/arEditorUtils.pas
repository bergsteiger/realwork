unit arEditorUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/arEditorUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::arEditorUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  kwClickOnCommentHeader,
  kwEditorDblClickOnSub,
  kwDeleteSub,
  kwDocEditorSetModified,
  kwAddBlock,
  kwEditorSetTOC,
  kwGotoSub,
  kwEndAddSubByMouse,
  kwSetExpiredStyle
  ;

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts
end.