unit m3DocumentIndexBuilder;

{ Библиотека "M3"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m3DocumentIndexBuilder - }
{ Начат: 20.02.2002 14:41 }
{ $Id: m3DocumentIndexBuilder.pas,v 1.3 2009/03/19 16:28:30 lulin Exp $ }

// $Log: m3DocumentIndexBuilder.pas,v $
// Revision 1.3  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.2  2008/02/29 08:24:14  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.1  2004/09/02 08:09:47  law
// - cleanup.
//
// Revision 1.4  2002/03/05 16:12:39  law
// - new behavior: реализован простейший поиск по полной базе документов.
//
// Revision 1.3  2002/02/21 15:58:16  law
// - optimization.
//
// Revision 1.2  2002/02/20 14:14:05  law
// - bug fix: неправильная функция сравнения адресов.
//
// Revision 1.1  2002/02/20 12:42:35  law
// - new units: первая реализация индексации документов.
//

{$I m3Define.inc}

interface

uses
  ActiveX,
  
  l3Types,
  l3Interfaces,
  l3Base,

  m3StorageInterfaces,
  m3Index,
  m3ParaIndexBuilder
  ;

type
  Tm3DocumentIndexBuilder = class(Tm3ParaIndexBuilder)
    protected
    // property methods
      function pm_GetCurrentDocument: Long;
      procedure pm_SetCurrentDocument(aValue: Long);
        {-}
    protected
    // internal methods
      function  GetToolsClass: Rm3ParaIndexBuilderTools;
        override;
        {-}
    public
    // public methods    
      constructor Create(const anIndexStorage : Im3IndexedStorage;
                         const aProgress      : Il3Progress = nil);
        reintroduce;
        {-}
    public
    // public properties
      property CurrentDocument: Long
        read pm_GetCurrentDocument
        write pm_SetCurrentDocument;
        {-}
  end;//Tm3DocumentIndexBuilder

  Tm3DocumentIndexBuilderTools = class(Tm3ParaIndexBuilderTools)
    public
    // public methods
      function  Compare(const AVal1: Pointer;
                        const AVal2: Pointer;
                        const ASize: LongInt): Integer;
        override;
        {-}
  end;//Tm3DocumentIndexBuilderTools

implementation

uses
  Math,

  m3DocumentAddress
  ;

// start class Tm3DocumentIndexBuilder

constructor Tm3DocumentIndexBuilder.Create(const anIndexStorage : Im3IndexedStorage;
                                           const aProgress      : Il3Progress = nil);
  //reintroduce;
  {-}
begin
 inherited Create(anIndexStorage,
                  aProgress,
                  SizeOf(Tm3DocumentAddress) - SizeOf(Tm3WordAddress));
end;
  
function  Tm3DocumentIndexBuilder.pm_GetCurrentDocument: Long;
  {-}
begin
 Result := Pm3DocumentAddress(f_CurrentAddress)^.rDocument;
end;

procedure Tm3DocumentIndexBuilder.pm_SetCurrentDocument(aValue: Long);
  {-}
begin
 with Pm3DocumentAddress(f_CurrentAddress)^ do begin
  rPara := 0;
  rDocument := aValue;
 end;//with Pm3DocumentAddress(f_CurrentAddress)^
end;

function Tm3DocumentIndexBuilder.GetToolsClass: Rm3ParaIndexBuilderTools;
  //override;
  {-}
begin
 Result := Tm3DocumentIndexBuilderTools;
end;

// start class Tm3DocumentIndexBuilderTools

function Tm3DocumentIndexBuilderTools.Compare(const AVal1: Pointer;
                                              const AVal2: Pointer;
                                              const ASize: LongInt): Integer;
  //override;
  {-}
begin
 if (aSize <> SizeOf(Tm3DocumentAddress)) then
  Result := -1
 else begin
  Result := Pm3DocumentAddress(AVal1).rDocument - Pm3DocumentAddress(AVal2).rDocument;
  if (Result = 0) then
   Result := inherited Compare(aVal1, aVal2, SizeOf(Tm3WordAddress))
  else
   Result := Sign(Result); 
 end;
end;

end.

