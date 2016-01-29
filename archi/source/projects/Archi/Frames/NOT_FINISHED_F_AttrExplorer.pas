unit NOT_FINISHED_F_AttrExplorer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Frames"
// Модуль: "w:/archi/source/projects/Archi/Frames/NOT_FINISHED_F_AttrExplorer.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi::Frames::Frames::F_AttrExplorer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
type
 TAttrExplorer = class
 end;//TAttrExplorer
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  Classes
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  AttributeExplorerWordsPack
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  
  ;

{$IfEnd} //AppClientSide
end.