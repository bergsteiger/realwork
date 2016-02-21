unit m3TempStream;

// Модуль: "w:\common\components\rtl\Garant\m3\m3TempStream.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3FileStream
 , ActiveX
;

type
 Tm3TempStream = class(Tm3FileStream)
  public
   constructor Create(const APath: WideString = '';
    const AExt: WideString = ''); reintroduce;
   class function Make(const APath: WideString = '';
    const AExt: WideString = ''): IStream; reintroduce;
 end;//Tm3TempStream

implementation

uses
 l3ImplUses
 , m2TMPLib
 , Windows
;

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
end;//Tm3TempStream.Make

end.
