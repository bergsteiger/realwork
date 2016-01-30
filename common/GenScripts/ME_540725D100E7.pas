unit NOT_FINISHED_m3Exceptions;

// ������: "w:\common\components\rtl\Garant\m3\NOT_FINISHED_m3Exceptions.pas"
// ���������: "UtilityPack"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , l3Except
;

type
 Em3Exception = class(El3Exception)
 end;//Em3Exception

 Em3InvalidStream = class(Em3Exception)
 end;//Em3InvalidStream

 Em3NilStream = class(Em3InvalidStream)
 end;//Em3NilStream

 Em3NoIndex = class(Em3Exception)
 end;//Em3NoIndex

implementation

uses
 l3ImplUses
 , SysUtils
;

end.
