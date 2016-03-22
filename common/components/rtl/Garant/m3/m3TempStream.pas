unit m3TempStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3TempStream.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3::Streams::Tm3TempStream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  ActiveX,
  m3FileStream
  ;

type
 Tm3TempStream = class(Tm3FileStream)
 public
 // public methods
   constructor Create(const APath: WideString = '';
     const AExt: WideString = ''); reintroduce;
   class function Make(const APath: WideString = '';
     const AExt: WideString = ''): IStream; reintroduce;
     {* Сигнатура фабрики Tm3TempStream.Make }
 end;//Tm3TempStream

implementation

uses
  m2TMPLib,
  Windows
  ;

// start class Tm3TempStream

constructor Tm3TempStream.Create(const APath: WideString = '';
  const AExt: WideString = '');
//#UC START# *5480A22102AA_5480A1E100B5_var*
 const
        CAccess=                  GENERIC_READ or
                                  GENERIC_WRITE;

        CSharedMode=              0;

        CDistribution=            OPEN_EXISTING;

        CFlags=                   FILE_ATTRIBUTE_HIDDEN or
                                  FILE_ATTRIBUTE_TEMPORARY or
                                  FILE_FLAG_DELETE_ON_CLOSE;
//#UC END# *5480A22102AA_5480A1E100B5_var*
begin
//#UC START# *5480A22102AA_5480A1E100B5_impl*
  inherited Create(m2TMPGetFileName(APath,AExt),CAccess,CSharedMode,CDistribution,CFlags);
//#UC END# *5480A22102AA_5480A1E100B5_impl*
end;//Tm3TempStream.Create

class function Tm3TempStream.Make(const APath: WideString = '';
  const AExt: WideString = ''): IStream;
var
 l_Inst : Tm3TempStream;
begin
 l_Inst := Create(APath, AExt);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

end.