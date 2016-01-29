unit OldTreeInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Model"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Model/OldTreeInterfaces.pas"
// Начат: 29.09.2009 19:56
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Базовые определения предметной области::LegalDomain::Model::OldTreeInterfaces
//
// Интерфейсы для работы со старыми деревьями
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  l3Interfaces
  ;

type
 InsWrapperNode = interface(IUnknown)
  {* описывает общее для объектов оберток адаптерных интерфейсов поведение }
   ['{056B6F80-4891-4D37-AA3B-0979EC152427}']
   function pm_GetName: Tl3WString;
   procedure pm_SetName(const aValue: Tl3WString);
   function pm_GetComment: Tl3WString;
   procedure pm_SetComment(const aValue: Tl3WString);
   property Name: Tl3WString
     read pm_GetName
     write pm_SetName;
   property Comment: Tl3WString
     read pm_GetComment
     write pm_SetComment;
 end;//InsWrapperNode
{$IfEnd} //not Admin

implementation

end.