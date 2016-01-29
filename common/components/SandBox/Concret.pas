unit Concret;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "Concret.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: Interfaces::Category Shared Delphi Sand Box::SandBox::Concret
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbDefine.inc}

interface

uses
  Pure
  ;

type
 Concret = interface(IUnknown)
   ['{14AF2DBE-A147-42ED-82B8-C7B7360DB3A8}']
  // Comparable
   function Compare(const x: Concret;
    const y: Concret): Integer;
 end;//Concret

implementation

end.