@ sub_string.s
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Arguments: a char string pointer and two integer indices
@ Returns: a pointer to a string
@ Register definitions:
@ r0 - pointer to string argument (char *in_string)
@ r1 - integer argument (int start_index)
@ r2 - integer argument (int end_index)
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 
.data
result:
	.space 100		@ User input size. 99 characters plus 1 for null terminator.		
.text
 
.global sub_string
 
sub_string:
	push {fp,lr} 		    @ save link reg then frame pointer (push args right to left)
				            @ lr holds PC value for return to calling routine
	mov fp,sp 		        @ sets up new frame above pushed regs at current top of stack 
 
	sub r1, r1, #1		    @ Subtract 1 from start_index
	sub r2, r2, #1		    @ Subtract 1 from end_index
 
	mov r5, r0	        	@  Move *in_string from r0 to r5	
	add r5, r1		        @ Add start_index offset to *in_string in r5
	ldr r4, =result	        @ Load r4 with a pointer to allocated memory region. This will be *out_string.
 
copy_string:
	cmp r1, r2		        @ Compare start_index (r1) to end_index (r2)
	bgt terminate_string	@ If r1 > r2, return empty substring
	
	ldrb r6, [r5]		    @ Load r6 with byte from address in r5 (which contains *in_string)
	add r5, r5, #1		    @ Move to next byte of r5
 
	cmp r6, #0		        @ Check if r6 contains the null terminator
	beq terminate_string	@ If it does, branch to terminate_string (*in_string has been fully read)
 
	strb r6, [r4]		    @ Store byte from r6 into address in r4 (which contains *out_string)
	add r4, r4, #1		    @ Move to next byte of r4
 
	add r1, r1, #1		    @ Increment r1 (which contains start_index) before looping
	b copy_string		    @ Loop by branching to copy_string
 
terminate_string:
	mov r7, #0		        @ Load r7 with a null terminator
	strb r7, [r4]		    @ Store null terminator at end of r4 (which contains *out_string)
 
	ldr r0, =result	        @ Load r0 with a pointer to the beginning of *out_string
 
	mov sp,fp 		        @ return top of stack to frame position at routine start
	pop {fp,pc} 		    @ restore frame pointer of caller and load PC with saved lr value