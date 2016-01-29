{*******************************************************}
{                                                       }
{            CodeGear Delphi Memory Manager             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{  Portions created by Pierre le Riche are              }
{   Copyright (c) Pierre le Riche /                     }
{     Professional Software Development                 }
{                                                       }
{  Acknowledgement: With special thanks to the Fastcode }
{    community and supporters for their valuable input  }
{    and feedback.                                      }
{                                                       }
{*******************************************************}

(* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1
 *
 * This memory manager implementation is subject to the
 * Mozilla Public License Version 1.1 (the "License"); you may
 * not use this file except in compliance with the License.
 * You may obtain a copy of the License at http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * ***** END LICENSE BLOCK ***** *)

unit System.SimpleShareMem;

interface

implementation

initialization
  {Try to use a shared memory manager. If one is not available, start sharing
   the current one.}
  If not AttemptToUseSharedMemoryManager then
    ShareMemoryManager

end.
