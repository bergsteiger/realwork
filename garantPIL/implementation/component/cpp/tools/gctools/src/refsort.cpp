#include "gardefs.h"
#include "refsort.h"


static inline void SWAP(Ref* A, Ref* B)
{
  Ref tmp = *A; *A = *B; *B = tmp;
}

#define CMPREF(a,b) ( ((a).DocId>(b).DocId)? 1: \
					   ((a).DocId<(b).DocId)?-1: \
					   ((a).Sub>(b).Sub)? 1: \
					   ((a).Sub<(b).Sub)?-1: 0 )
					   

/* This should be replaced by a standard ANSI macro. */
#define BYTES_PER_WORD 8
#define BYTES_PER_LONG 4

/* The next 4 #defines implement a very fast in-line stack abstraction. */

#define STACK_SIZE (BYTES_PER_WORD * BYTES_PER_LONG)
#define PUSH(LOW,HIGH) do {top->lo = LOW;top++->hi = HIGH;} while (0)
#define POP(LOW,HIGH)  do {LOW = (--top)->lo;HIGH = top->hi;} while (0)
#define STACK_NOT_EMPTY (stack < top)                

/* Discontinue quicksort algorithm when partition gets below this size.
   This particular magic number was chosen to work best on a Sun 4/260. */
#define MAX_THRESH 4


/* Order size using quicksort.  This implementation incorporates
   four optimizations discussed in Sedgewick:
   
   1. Non-recursive, using an explicit stack of pointer that
      store the next array partition to sort.  To save time, this
      maximum amount of space required to store an array of
      MAX_INT is allocated on the stack.  Assuming a 32-bit integer,
      this needs only 32 * sizeof (stack_node) == 136 bits.  Pretty
      cheap, actually.

   2. Chose the pivot element using a median-of-three decision tree.
      This reduces the probability of selecting a bad pivot value and 
      eliminates certain extraneous comparisons.

   3. Only quicksorts TOTAL_ELEMS / MAX_THRESH partitions, leaving
      insertion sort to order the MAX_THRESH items within each partition.  
      This is a big win, since insertion sort is faster for small, mostly
      sorted array segements.
   
   4. The larger of the two sub-partitions is always pushed onto the
      stack first, with the algorithm then concentrating on the
      smaller partition.  This *guarantees* no more than log (n)
      stack size is needed! */
      
int sortRefs (Ref *base_ptr, int total_elems)
{
/* Stack node declarations used to store unfulfilled partition obligations. */
  struct stack_node {  Ref *lo;  Ref *hi; };
  Ref   pivot_buffer;
  int   max_thresh   = MAX_THRESH;

  if (total_elems > MAX_THRESH)
    {
      Ref       *lo = base_ptr;
      Ref       *hi = lo + (total_elems - 1);
      Ref       *left_ptr;
      Ref       *right_ptr;
      stack_node stack[STACK_SIZE]; /* Largest size needed for 32-bit int!!! */
      stack_node *top = stack;

      for (;;)
        {
          {
            Ref *pivot = &pivot_buffer;
            {
              /* Select median value from among LO, MID, and HI. Rearrange
                 LO and HI so the three values are sorted. This lowers the 
                 probability of picking a pathological pivot value and 
                 skips a comparison for both the LEFT_PTR and RIGHT_PTR. */

              Ref *mid = lo + ((hi - lo) >> 1);

              if ( CMPREF(*mid, *lo) < 0)
                SWAP (mid, lo);
              if (CMPREF(*hi, *mid) < 0)
              {
                SWAP (mid, hi);
                if (CMPREF(*mid, *lo) < 0)
                  SWAP (mid, lo);
              }
              *pivot = *mid;
              pivot = &pivot_buffer;
            }
            left_ptr  = lo + 1;
            right_ptr = hi - 1; 

            /* Here's the famous ``collapse the walls'' section of quicksort.  
               Gotta like those tight inner loops!  They are the main reason 
               that this algorithm runs much faster than others.

	       [Yeah, but there is a function call in the inner loop,
	       which makes the speed claim rather dubious.  --Per Bothner] */
            do 
              {
                while ( CMPREF(*left_ptr, *pivot) < 0)
                  left_ptr += 1;

                while ( CMPREF(*pivot, *right_ptr) < 0)
                  right_ptr -= 1;

                if (left_ptr < right_ptr) 
                  {
                    SWAP (left_ptr, right_ptr);
                    left_ptr += 1;
                    right_ptr -= 1;
                  }
                else if (left_ptr == right_ptr) 
                  {
                    left_ptr += 1;
                    right_ptr -= 1;
                    break;
                  }
              } 
            while (left_ptr <= right_ptr);

          }

          /* Set up pointers for next iteration.  First determine whether
             left and right partitions are below the threshold size. If so, 
             ignore one or both.  Otherwise, push the larger partition's
             bounds on the stack and continue sorting the smaller one. */

          if ((right_ptr - lo) <= max_thresh)
            {
              if ((hi - left_ptr) <= max_thresh)
		{ /* Ignore both small partitions. */
		  if (STACK_NOT_EMPTY)
		    POP (lo, hi);
		  else
		    break;  /* No pending partitions - we're done. */
		}
              else              /* Ignore small left partition. */  
                lo = left_ptr;
            }
          else if ((hi - left_ptr) <= max_thresh) /* Ignore small right partition. */
            hi = right_ptr;
          else if ((right_ptr - lo) > (hi - left_ptr)) /* Push larger left partition indices. */
            {                   
              PUSH (lo, right_ptr);
              lo = left_ptr;
            }
          else                  /* Push larger right partition indices. */
            {                   
              PUSH (left_ptr, hi);
              hi = right_ptr;
            }
        }
    }

  /* Once the BASE_PTR array is partially sorted by quicksort the rest
     is completely sorted using insertion sort, since this is efficient 
     for partitions below MAX_THRESH size. BASE_PTR points to the beginning 
     of the array to sort, and END_PTR points at the very last element in
     the array (*not* one beyond it!). */


  {
    Ref *end_ptr = base_ptr + 1 * (total_elems - 1);
    Ref *run_ptr;
    Ref *tmp_ptr = base_ptr;
    Ref *thresh  = (end_ptr < (base_ptr + max_thresh))? 
      end_ptr : (base_ptr + max_thresh);

    /* Find smallest element in first threshold and place it at the
       array's beginning.  This is the smallest array element,
       and the operation speeds up insertion sort's inner loop. */

    for (run_ptr = tmp_ptr + 1; run_ptr <= thresh; run_ptr += 1)
      if ( CMPREF(*run_ptr, *tmp_ptr) < 0)
        tmp_ptr = run_ptr;

    if (tmp_ptr != base_ptr)
      SWAP (tmp_ptr, base_ptr);

    /* Insertion sort, running from left-hand-side up to `right-hand-side.' 
       Pretty much straight out of the original GNU qsort routine. */

    for (run_ptr = base_ptr + 1; (tmp_ptr = run_ptr += 1) <= end_ptr; )
      {

        while ( CMPREF(*run_ptr, *(tmp_ptr -= 1)) < 0)
          ;

        if ((tmp_ptr += 1) != run_ptr)
          {
            Ref *trav;

            for (trav = run_ptr + 1; --trav >= run_ptr;)
              {
                Ref c = *trav;
                Ref *hi, *lo;

                for (hi = lo = trav; (lo -= 1) >= tmp_ptr; hi = lo)
                  *hi = *lo;
                *hi = c;
              }
          }

      }
  }
  return 1;
}
