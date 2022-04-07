	.balign 0x20
vector_table_base_address:
	B 	reset_handler
	B 	undefined_handler
	B 	svc_handler
	B 	prefetch_handler
	B 	data_handler
	NOP
	B 	IRQ_handler
	// You can place the FIQ handler code here.

	LDR	R1, =secure_vector_table_base_address
	MCR	P15, 0, R1, C12, C0, 0 // Initialize VBAR (Secure).
	LDR	R1, =monitor_vector_table_base_address
	MCR	P15, 0, R1, C12, C0, 1 // Initialize MVBAR.

	// Enable asynchronous aborts, interrupts, and fast interrupts.
	CPSIE	aif

	// Processors are in Secure SVC mode after reset.
	MOV	R0, #0
	MOV	R1, #0
	MOV	R2, #0
	MOV	R3, #0
	MOV	R4, #0
	MOV	R5, #0
	MOV	R6, #0
	MOV	R7, #0
	MOV	R8, #0
	MOV	R9, #0
	MOV	R10, #0
	MOV	R11, #0
	MOV	R12, #0
	MOV	R13, #0
	MOV	R14, #0
	CPS	#0x11		// Change to FIQ mode.
	MOV	R8, #0
	MOV	R9, #0
	MOV	R10, #0
	MOV	R11, #0
	MOV	R12, #0
	MOV	R13, #0
	MOV	R14, #0

	CPS	#0x12		// Change to IRQ mode.
	MOV	R13, #0
	MOV	R14, #0

	CPS	#0x1F		// Change to System mode.
	MOV	R13, #0		// System and User modes reuse the same banking
	MOV	R14, #0		// of r13 and r14.

	CPS	#0x17		// Change to Abort mode.
	MOV	R13, #0
	MOV	R14, #0

	CPS	#0x1B		// Change to Undef mode.
	MOV	R13, #0
	MOV	R14, #0

	CPS	#0x16		// Change to Monitor mode.
	MOV	R13, #0
	MOV	R14, #0

	MOV	R0, #0		// Use MSR in Monitor Mode.
	MSR	SP_hyp, R0	// Initialize Hyp mode R13.
