/*=============================================================================
 Debug support (stack trace)
 http://www.codesourcery.com/public/cxx-abi/abi-eh.html
=============================================================================*/
#include <stdio.h>
#include <windows.h>
//#include <eh.h>
#include "unwind_cpp_support.hpp"
#include "ms_api.hpp"

namespace ms_api
{
#define PRINT_REGISTERS

  void stack_trace()
  {
    context ctx;
    non_volatile_context_pointers nv_ctx;
    unwind_history_table unwind_history;
    runtime_function* runtime_fn;
    void* handler_data;
    uint64 establisher_frame;
    uint64 image_base;

    printf("-----------------------------------------\n");
    printf("StackTrace64: Executing stack trace...\n");
    printf("-----------------------------------------\n");

    // First, we'll get the caller's context.
    RtlCaptureContext(&ctx);

    // Initialize the (optional) unwind history table.
    RtlZeroMemory(
      &unwind_history,
      sizeof(UNWIND_HISTORY_TABLE));

    //	unwind_history.Unwind = TRUE;

    // This unwind loop intentionally skips the first call frame, as it shall
    // correspond to the call to StackTrace64, which we aren't interested in.
    for (ULONG frame = 0;;frame++)
    {
      // Try to look up unwind metadata for the current function.
      runtime_fn = RtlLookupFunctionEntry(
        ctx.Rip,
        &image_base,
        &unwind_history);

      RtlZeroMemory(
        &nv_ctx,
        sizeof(non_volatile_context_pointers));

      if (!runtime_fn)
      {
        // If we don't have a RUNTIME_FUNCTION, then we've encountered
        // a leaf function.  Adjust the stack approprately.
        ctx.Rip  = (uint64)(*(uint64*)ctx.Rsp);
        ctx.Rsp += 8;

        printf("No RUNTIME_FUNCTION info\n");
      }
      else
      {
        // Otherwise, call upon RtlVirtualUnwind to execute the unwind for
        // us.

        printf("ImageBase: %p\n", image_base);
        printf("Start: %p\n", runtime_fn->BeginAddress);
        printf("End: %p\n", runtime_fn->EndAddress);

        RtlVirtualUnwind(
          0x0,                  // HandlerType (UNW_FLAG_NHANDLER)
          image_base,           // ImageBase
          ctx.Rip,              // ControlPC
          runtime_fn,           // FunctionEntry
          &ctx,                 // ContextRecord
          &handler_data,        // InFunction
          &establisher_frame,   // EstablisherFrame
          &nv_ctx);             // ContextPointers
      }

      // If we reach an RIP of zero, this means that we've walked off the end
      // of the call stack and are done.
      if (!ctx.Rip)
        break;

      printf("-----------------------------------------\n");

#ifdef PRINT_REGISTERS
      //
      // Display the context.  Note that we don't bother showing the XMM
      // context, although we have the nonvolatile portion of it.
      //

      printf(
        "FRAME %02x: Rip=%p Rsp=%p Rbp=%p\n",
        frame, ctx.Rip, ctx.Rsp, ctx.Rsp);

      printf(
        "r12=%p r13=%p r14=%p\n"
        "rdi=%p rsi=%p rbx=%p\n"
        "rbp=%p rsp=%p\n",
        ctx.R12, ctx.R13, ctx.R14, ctx.Rdi,
        ctx.Rsi, ctx.Rbx, ctx.Rbp, ctx.Rsp
        );

      static const CHAR* reg_names[16] =
      { "Rax", "Rcx", "Rdx", "Rbx", "Rsp", "Rbp", "Rsi", "Rdi", "R8", "R9",
        "R10", "R11", "R12", "R13", "R14", "R15" };

      //
      // If we have stack-based register stores, then display them here.
      //

      for (uint32 i = 0; i < 16; i++)
      {
        if (nv_ctx.IntegerContext[i])
        {
          printf(
            " -> Saved register '%s' on stack at %p (=> %p)\n",
            reg_names[ i ],
            nv_ctx.IntegerContext[ i ],
            *nv_ctx.IntegerContext[ i ]);
        }
      }

      printf("\n");
#endif
    }

    return;
  }
}

