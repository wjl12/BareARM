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

	// Enable access to FP registers.
	MOV	R1, #(0xF << 20)
	MCR	P15, 0, R1, C1, C0, 2 // CPACR full access to cp11 and cp10. MOV R1, #(0x1 << 30)
	// Enable Floating point and Neon unit.
	VMSR	FPEXC, R1	// Set FPEXC.EN.
	ISB			// Ensure the enable operation takes effect.

	MOV	R1, #0
	MOV	R2, #0
	VMOV.F64 D0, R1, R2
	VMOV.F64 D1, D0
	VMOV.F64 D2, D0
	VMOV.F64 D3, D0
	VMOV.F64 D4, D0
	VMOV.F64 D5, D0
	VMOV.F64 D6, D0
	VMOV.F64 D7, D0
	VMOV.F64 D8, D0
	VMOV.F64 D9, D0
	VMOV.F64 D10, D0
	VMOV.F64 D11, D0
	VMOV.F64 D12, D0
	VMOV.F64 D13, D0
	VMOV.F64 D14, D0
	VMOV.F64 D15, D0
	VMOV.F64 D16, D0
	VMOV.F64 D17, D0
	VMOV.F64 D18, D0
	VMOV.F64 D19, D0
	VMOV.F64 D20, D0
	VMOV.F64 D21, D0
	VMOV.F64 D22, D0
	VMOV.F64 D23, D0
	VMOV.F64 D24, D0
	VMOV.F64 D25, D0
	VMOV.F64 D26, D0
	VMOV.F64 D27, D0
	VMOV.F64 D28, D0
	VMOV.F64 D29, D0
	VMOV.F64 D30, D0
	VMOV.F64 D31, D0
